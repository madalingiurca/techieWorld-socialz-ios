//
//  ContentView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack(spacing: 30.0) {
            VStack(alignment: .center, spacing: 0.0) {
                Text("Techie World")
                    .font(.largeTitle)
                    .bold()
                Text("Socialz")
                    .font(.title2)
                    .italic()
                    .bold()
            }
            .ignoresSafeArea(.keyboard)
            
            Spacer()
            LoginFormView(authentication: authentication)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Sign up, if you’re new!")
                    .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
            }
            .padding(.bottom,30)
        }
    }
    

}

struct CustomTextM: ViewModifier {
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color

    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .environmentObject(Authentication())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
