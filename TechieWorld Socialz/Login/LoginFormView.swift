//
//  LoginForm.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct LoginFormView: View {
    @State private var username = "user"
    @State private var password = "pass"
    @State var authentication: Authentication
    
    var body: some View {
        VStack {
            TwTextField("Username", value: $username)
                .autocapitalization(.none)
            TwSecureField("Password", value: $password)
                .autocapitalization(.none)
            LogInButton(authentication: authentication, username: username, password: password)
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(authentication: Authentication())
            .previewLayout(.sizeThatFits)
    }
}
