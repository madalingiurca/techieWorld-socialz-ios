//
//  PostView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 20.04.2022.
//

import SwiftUI

struct PostCard: View {
    
    let postContent: String
    let author: String
    let numberOfComments: Int
    
    var body: some View {
        VStack {
            Text(postContent)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            
            Spacer()
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
                        .padding(.trailing, 5)
                }
                
                
            }
            .font(.subheadline)
        }
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCard(postContent: "There", author: "JoeDoe", numberOfComments: 20)
                .previewLayout(.fixed(width: 400, height: 200))
            PostCard(postContent: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.", author: "JoeDoe", numberOfComments: 20)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 200))
        }
    }
}
