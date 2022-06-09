//
//  FloatingButton.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 08.06.2022.
//

import SwiftUI

struct CreateNewPostButton: View {
    @State var isViewingPostCreator = false

    var body: some View {
        VStack{
            Spacer()
            HStack(alignment: .top) {
                Spacer()
                Button(action: {
                    isViewingPostCreator = true
                }) {
                    Image(systemName: "plus.bubble.fill")
                        .resizable()
                        .foregroundColor(Color.primary)
                        .frame(width: 40, height: 40, alignment: .center)
                }
            }
            .padding(.trailing)
        }
        .sheet(isPresented: $isViewingPostCreator) {
            PostCreatorView(isPresented: $isViewingPostCreator)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPostButton()
    }
}
