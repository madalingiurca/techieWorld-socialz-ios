//
//  ContentView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 30.0) {
            VStack(alignment: .center, spacing: 0.0) {
                Text("Techie World")
                    .font(.largeTitle)
                    .bold()
                Text("SocialZ")
                    .font(.title2)
                    .bold()
            }
            Spacer()
            LoginForm()
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Sign up, if you’re new!")
                    .modifier(CustomTextM(fontName: "RobotoSlab-Light", fontSize: 18, fontColor: Color.primary))
            }
            .padding(.bottom,30)
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}