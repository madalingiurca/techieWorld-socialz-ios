//
//  PostView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 20.04.2022.
//

import SwiftUI

struct PostCard: View {

    let post: Post
    let numberOfComments: Int
    private var postContent: String { post.content }
    private var author: String { post.author }
    
    var body: some View {
        VStack {
            Text(postContent)
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 150, alignment: .topLeading)
                .padding([.top, .leading, .trailing])

            HStack() {
                HStack {
                    Image(systemName: "text.bubble.fill")
                    Text("\(numberOfComments)")
                }

                Spacer()

                HStack {
                    Image(systemName: "at.circle.fill")
                    Text("\(author)")
                        .fontWeight(.bold)
                }


            }
            .font(.subheadline)
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color(uiColor: .systemGray5))
        .cornerRadius(10)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCard(post: Post(id: 1, author: "Joe Doe", content: "There"),
                     numberOfComments: 2)
                .previewLayout(.fixed(width: 400, height: 200))
            PostCard(post: Post(id: 2, author: "Nomad", content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
                     numberOfComments: 20)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 200))
        }
    }
}
