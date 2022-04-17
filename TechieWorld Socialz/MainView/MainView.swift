//
//  SwiftUIView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        
        VStack {
            Text("Hello, you're authenticated!")
            Text("Here is your acessToken")
            Spacer()
            Text(authentication.accessToken)
                .bold()
            Spacer()
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let auth = Authentication();
        auth.isAuthenticated = true
        auth.accessToken = "my-access-token"
        
        return MainView()
            .environmentObject(auth)
    }
}
