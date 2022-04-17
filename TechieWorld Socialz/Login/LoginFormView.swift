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
    @State private var awaitingLogin = false
    
    @State var authentication: Authentication
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.title2)
                .padding()
            TextField("Username", text: $username)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            if (awaitingLogin) {
                ProgressView()
            }
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
                Text("Login")
            })
            .alert("Login failed", isPresented: ($errorOccured) ) {
                Button("OK") {
                }
            } message: {
                Text(authenticationErrorMessage)
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.green)
            .cornerRadius(20)
        }
    }
}

struct CustomTextM: ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(authentication: Authentication())
    }
}
