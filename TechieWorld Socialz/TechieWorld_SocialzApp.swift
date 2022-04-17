//
//  TechieWorld_SocialzApp.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

@main
struct TechieWorld_SocialzApp: App {
    @StateObject var authentication: Authentication
    
    init() {
        self._authentication = StateObject(wrappedValue: Authentication())
    }
    
    var body: some Scene {
        WindowGroup {
            if authentication.isAuthenticated {
                MainView()
                    .environmentObject(authentication)
            }
            else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
