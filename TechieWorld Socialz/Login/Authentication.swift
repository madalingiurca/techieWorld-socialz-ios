//
//  Authentication.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

class Authentication: ObservableObject {
    @Published var isAuthenticated = false
    @Published var showProgressView = false
    var accessToken: String = "";
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) async {
        showProgressView = true
        try? await WebService.shared.singIn(username: username, password: username) {
            [unowned self](result:Result<String, WebService.AuthenticationError>) in
         showProgressView = false
            switch result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
