//
//  LoginForm.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct LoginFormView: View {
    @State private var authenticationErrorMessage = ""
    @State private var errorOccured = false
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var authorizationFails = false
    @State var awaitingLogin = false
    
    @State var authentication: Authentication
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .autocapitalization(.none)
                .disabled(awaitingLogin)
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .disabled(awaitingLogin)
            if (awaitingLogin) {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(20)
            }
            else {
                Button(action: {
                    Task {
                        awaitingLogin = true
                        await authentication.login(username: username, password: password) {
                            result in switch result {
                            case .success(_):
                                awaitingLogin = false
                                authentication.isAuthenticated = true
                            case .failure(let authError):
                                errorOccured = true
                                authenticationErrorMessage = authError.localizedDescription
                                awaitingLogin = false
                            }
                        }
                        
                    }
                }, label: {
                    VStack {
                        if awaitingLogin {
                            Text("Here")
                        } else {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .background(Color.green)
                                .cornerRadius(20)
                        }
                    }
                })
                .alert("Login failed", isPresented: ($errorOccured) ) {
                    Button("OK") {
                    }
                } message: {
                    Text(authenticationErrorMessage)
                }
            }
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(authentication: Authentication())
    }
}
