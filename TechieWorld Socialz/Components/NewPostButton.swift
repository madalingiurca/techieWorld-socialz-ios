//
//  FloatingButton.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 08.06.2022.
//

import SwiftUI

struct NewPostButton: View {
    @State var isViewingPostCreator = false
    @State var loading = false
    let dataSource: PostDataSource

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
        .fullScreenCover(isPresented: $isViewingPostCreator) {
            PostCreatorView(dataSource: dataSource,
                            isPresented: $isViewingPostCreator)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        let datasource = PostDataSource()

        return Group {
            NewPostButton(dataSource: datasource)
            NewPostButton(dataSource: datasource)
                .preferredColorScheme(.dark)
        }
    }
}
