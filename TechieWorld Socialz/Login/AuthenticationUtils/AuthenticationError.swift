//
//  AuthenticationError.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

enum AuthenticationError: Error, LocalizedError, Identifiable {
    case invalidCredentials
    case unknownAuthenticationError
    case connectionFailure
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return NSLocalizedString("Invalid username or password. Please try again", comment: "")
        case .unknownAuthenticationError:
            return NSLocalizedString("Unkown authentication error", comment: "")
        case .connectionFailure:
            return NSLocalizedString("Failed to connect to TechieWorld server", comment: "")
        }
    }
}
