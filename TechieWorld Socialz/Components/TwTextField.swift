//
//  TwTextField.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 04.06.2022.
//

import SwiftUI

struct TwTextField: View {
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
        TextField(label, text: $value)
            .padding(.horizontal)
            .frame(width: width, height: height)
            .background(background)
            .cornerRadius(radius)
    }
}

struct TwTextField_Previews: PreviewProvider {
    static var previews: some View {
        TwTextField("Title", value: .constant("value"))
            .previewLayout(.sizeThatFits)
    }
}
