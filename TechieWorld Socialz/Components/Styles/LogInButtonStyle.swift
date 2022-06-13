//
//  LogInButtonStyle.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 08.06.2022.
//

import SwiftUI

struct LogInButtonStyle: ButtonStyle {
    var width = 300.0
    var height = 50.0
    var radius = 10.0
    var color = Color(UIColor.systemGreen)
    var textColor = Color.white
    var textSize = 20.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: radius))
            .frame(width: width, height: height)
            .foregroundColor(textColor)
            .font(.system(size: textSize))
            .background(color)
            .cornerRadius(radius)
    }
}
