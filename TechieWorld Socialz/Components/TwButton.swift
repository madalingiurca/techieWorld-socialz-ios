//
//  TwButton.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 04.06.2022.
//

import SwiftUI

struct TwButton<Content: View>: View {
    var loading = false
    var spinnerColor = Color.primary

    var action: () -> Void
    let content: () -> Content

    init(loading: Bool = false,
         spinnerColor: Color = .primary,
         _ action: @escaping () -> Void,
         _ content: @escaping () -> Content
    ) {
        self.loading = loading
        self.spinnerColor = spinnerColor
        self.action = action
        self.content = content
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if (loading) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primary))
                } else {
                    content()
                }
            }
        }
    }
}

extension TwButton where Content == Text {
    init(_ label: String,
         loading: Bool = false,
         spinnerColor: Color = .primary,
         _ action: @escaping () -> Void
    ) {
        self.init(loading: loading, spinnerColor: spinnerColor, action) {
            Text(label)
        }
    }
}

struct TwButton_Previews: PreviewProvider {
    static var previews: some View {
        TwButton("Button Label", loading: false) {
        }
        .previewLayout(.sizeThatFits)
    }
}
