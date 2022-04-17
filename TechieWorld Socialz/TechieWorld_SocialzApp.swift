//
//  TechieWorld_SocialzApp.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

@main
struct TechieWorld_SocialzApp: App {
    @StateObject var authentication: Authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if (authentication.isAuthenticated) {
                MainView()
            }
            else {
                LoginView()
            }
        }
    }
}
