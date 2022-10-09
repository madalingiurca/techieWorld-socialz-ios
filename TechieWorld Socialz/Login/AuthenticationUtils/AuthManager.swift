//
//  Authentication.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

@MainActor
class AuthManager: ObservableObject {
    var accessToken: String?
    @Published var isAuthenticated = false
    
    private let kAccount = "user"
    private let kService = "techie-world-socialz"
    
    init() {
        if let jwt = retrieveJWT() {
            setAuthToken(jwt)
        } else {
            clearAuthToken()
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Result<AuthManager, AuthenticationError>) -> Void) async {
        await WebService.shared.singIn(username: username, password: password) {
            [unowned self](result:Result<String, AuthenticationError>) in
            switch result {
            case .success(let responseToken):
                setAuthToken(responseToken)
                let stored = storeJWT(responseToken)
                if stored {
                    completion(.success(self))
                } else {
                    completion(.failure(.unknownAuthenticationError))
                }
            case .failure(let authError):
                if (authError == .invalidCredentials) {
                    accessToken = nil
                    deleteJWT()
                }
                completion(.failure(authError))
            }
        }
    }
    
    func setAuthToken(_ token: String) {
        self.accessToken = token
        self.isAuthenticated = true
        AuthDetails.shared.token = self.accessToken
    }
    
    func clearAuthToken() {
        self.accessToken = nil
        self.isAuthenticated = false
        AuthDetails.shared.token = nil
    }
    
    func validateAuthToken(_ token: String?) -> Bool {
        guard let jwtComponents = token?.components(separatedBy: ".") else {
            return false;
        }
        
        if let decodedPayload = decodeJWTPart(part: jwtComponents[1]) {
            debugPrint("JWT payload: " + String(data: try! JSONEncoder().encode(decodedPayload), encoding: .utf8)!)
        }
        
        return validateJwtSignature(signedJwt: token!);
    }
    
    private func storeJWT(_ jwt: String) -> Bool {
        deleteJWT()
        
        let addquery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: kAccount,
            kSecAttrService: kService,
            kSecValueData: jwt.data(using: .utf8)!,
        ] as CFDictionary
        
        let status = SecItemAdd(addquery as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else {
            print("Store key: '\(jwt)' in Keychain failed with status: \(status.description)")
            return false
        }
    }
    
    private func retrieveJWT() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: kAccount,
            kSecAttrService: kService,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        let jwt = String(data: (result as? Data ?? Data.init()), encoding: .utf8);
        
        if status == errSecSuccess && validateAuthToken(jwt) {
            return jwt;
        }
        
        return nil;
    }
    
    private func deleteJWT() {
        let query = [
            kSecAttrService: "techie-world-socialz",
            kSecAttrAccount: "user",
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        SecItemDelete(query)
    }
    
}

class AuthDetails {
    static var shared = AuthDetails()
    var token: String?
}

struct AuthToken: Codable {
    var alias: String
    var username: String
}
