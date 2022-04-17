//
//  RestClient.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

class RestClient {
    var urlString = "http://localhost:8080/login"
    
    func singIn(username: String, password: String) async
    throws {
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
        guard (response as? HTTPURLResponse)?.statusCode == 202 else { throw FetchError.badRequest }
    
        guard let accessToken = (response as? HTTPURLResponse)?
            .value(forHTTPHeaderField: "Authorization")?
            .split(separator: " ")[1] else { return };
        
        print(accessToken)
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
}
