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
    
    var body: some View {
        VStack {
            TwTextField("Username", value: $username)
                .autocapitalization(.none)
            TwSecureField("Password", value: $password)
                .autocapitalization(.none)
            LogInButton(username: username, password: password)
        }
    }
}

struct LoginFormView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView()
            .previewLayout(.sizeThatFits)
    }
}
