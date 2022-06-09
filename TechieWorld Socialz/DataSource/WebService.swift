//
//  RestClient.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

@MainActor
class WebService {
    private let urlString = API.URL + "/login"
    static let shared = WebService()
    
    
    func singIn(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) async {
        guard let url = URL(string: urlString) else { return }
        let json: [String: Any] = ["username": username,
                                   "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (_, response) = try await (URLSession.shared.data(for: request))
            switch (response as? HTTPURLResponse)?.statusCode {
            case 202:
                guard let accessToken = (response as? HTTPURLResponse)?
                    .value(forHTTPHeaderField: "Authorization")?
                    .split(separator: " ")[1] else { completion(.failure(.unknownAuthenticationError)); return}
                completion(.success(String(accessToken)))
            case 401:
                completion(.failure(.invalidCredentials))
            case .none:
                completion(.failure(.unknownAuthenticationError))
            case .some(_):
                completion(.failure(.unknownAuthenticationError))
            }
        } catch {
            completion(.failure(.connectionFailure))
        }
        
        
    }
}
