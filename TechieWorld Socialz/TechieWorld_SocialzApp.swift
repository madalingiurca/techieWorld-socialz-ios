//
//  TechieWorld_SocialzApp.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

@main
struct TechieWorld_SocialzApp: App {
    @StateObject var authManager: AuthManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainView()
            }
            else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}
