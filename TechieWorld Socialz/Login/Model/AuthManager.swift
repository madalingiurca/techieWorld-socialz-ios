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
            // TODO: check if token is valid
            setAuthToken(jwt)
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Result<AuthManager, AuthenticationError>) -> Void) async {
        await WebService.shared.singIn(username: username, password: password) {
            [unowned self](result:Result<String, AuthenticationError>) in
            switch result {
            case .success(let responseToken):
                isAuthenticated = true
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

    private func storeJWT(_ jwt: String) -> Bool {
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

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        if status == errSecSuccess {
            return String(data: result as! Data, encoding: .utf8)!
        } else {
            return nil
        }
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
