//
//  LogInButton.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 04.06.2022.
//

import SwiftUI

struct LogInButton: View {

    @EnvironmentObject var authentication: AuthManager
    var username = ""
    var password = ""

    @State var isLoggingIn = false
    @State var authError = false
    @State var authErrorMessage = ""

    var body: some View {
        TwButton("Log In", loading: isLoggingIn) {
            Task {
                isLoggingIn = true
                await authentication.login(username: username, password: password) {
                    result in switch result {
                    case .success(_):
                        authentication.isAuthenticated = true
                    case .failure(let error):
                        authError = true
                        authErrorMessage = error.localizedDescription
                    }
                }
                isLoggingIn = false
            }
        }
        .alert(isPresented: $authError) {
            Alert(
                title: Text("Login Failed"),
                message: Text(authErrorMessage)
            )
        }
        .disabled(username.isEmpty || username.isEmpty)
        .buttonStyle(LogInButtonStyle())
    }
}

struct LogInButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInButton()
            .environmentObject(AuthManager())
            .previewLayout(.sizeThatFits)
    }
}
