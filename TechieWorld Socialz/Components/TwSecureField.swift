//
//  TwSecureField.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 04.06.2022.
//

import SwiftUI

struct TwSecureField: View {
    var label: String
    @Binding var value: String

    let width = 300.0
    let height = 50.0
    let background = Color(UIColor.systemGray6)
    let radius = 10.0

    init(_ label: String, value: Binding<String>) {
        self.label = label
        self._value = value
    }

    var body: some View {
        SecureField(label, text: $value)
            .padding()
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(radius)
    }
}

struct TwSecureField_Previews: PreviewProvider {
    static var previews: some View {
        TwSecureField("Secure", value: .constant("value"))
            .previewLayout(.sizeThatFits)
    }
}
