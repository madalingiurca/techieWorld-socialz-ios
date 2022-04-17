//
//  RestClient.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

class WebService {
    private let urlString = "http://localhost:8080/login"
    static let shared = WebService()
    
    
    func singIn(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) async throws {
        guard let url = URL(string: urlString) else { return }
        let json: [String: Any] = ["username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        if (response as? HTTPURLResponse)?.statusCode == 202 {
            guard let accessToken = (response as? HTTPURLResponse)?
                .value(forHTTPHeaderField: "Authorization")?
                .split(separator: " ")[1] else { completion(.failure(.unknownAuthenticationError)); return};
            
            print(accessToken)
            
            completion(.success(String(accessToken)))
        } else {
            completion(.failure(.unknownAuthenticationError))
            
        }
    }
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case unknownAuthenticationError
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Either your email or password are incorrect. Please try again", comment: "")
            case .unknownAuthenticationError:
                return NSLocalizedString("Unkown authentication error", comment: "")
            }
        }
    }
}
