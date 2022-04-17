//
//  Authentication.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

@MainActor
class Authentication: ObservableObject {
    var accessToken: String = ""
    @Published var isAuthenticated = false
    
    func login(username: String, password: String, completion: @escaping (Result<Authentication, AuthenticationError>) -> Void) async {
        await WebService.shared.singIn(username: username, password: password) {
            [unowned self](result:Result<String, AuthenticationError>) in
            switch result {
            case .success(let responseToken):
                isAuthenticated = true
                accessToken = responseToken
                completion(.success(self))
            case .failure(let authError):
                accessToken.removeAll()
                completion(.failure(authError))
            }
        }
    }
}
