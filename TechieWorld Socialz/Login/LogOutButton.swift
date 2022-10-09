//
//  LogOutButton.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 09.10.2022.
//

import SwiftUI

struct LogOutButton: View {

    @EnvironmentObject var authentication: AuthManager

    var body: some View {
        TwButton("Log out") {
            Task {
                authentication.clearAuthToken()
            }
        }
        .buttonStyle(LogOutButtonStyle())
    }
}

struct LogOutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInButton()
            .environmentObject(AuthManager())
            .previewLayout(.sizeThatFits)
    }
}
