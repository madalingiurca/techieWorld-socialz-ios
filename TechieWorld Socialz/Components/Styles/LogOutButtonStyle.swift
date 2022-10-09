//
//  LogOutButtonStyle.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 09.10.2022.
//

import Foundation

import SwiftUI

struct LogOutButtonStyle: ButtonStyle {
    var width = 70.0
    var height = 40.0
    var radius = 10.0
    var color = Color(UIColor.systemRed)
    var textColor = Color.white
    var textSize = 14.0

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
