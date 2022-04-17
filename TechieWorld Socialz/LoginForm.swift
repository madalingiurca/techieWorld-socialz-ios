//
//  LoginForm.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct LoginForm: View {
    
    private var client = RestClient()
    
    @State private var username = ""
    @State private var password = ""

    @State private var showingLoginScreen = false
    @State private var awaitingLogin = false
    
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

            Button(action: {
                Task {
                    awaitingLogin = true
                    try? await client.singIn(username: username, password: password)
                }
            }, label: {
                Text("Login")
            })
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

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
