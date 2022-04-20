//
//  PostView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 20.04.2022.
//

import SwiftUI

struct PostView: View {
    
    let postContent: String
    let author: String
    let numberOfComments: Int
    
    var body: some View {
        VStack{
            Text(postContent)
                .padding()
                .lineLimit(10)
            
            Spacer()
            HStack() {
                HStack {
                    Image(systemName: "text.bubble.fill")
                    Text("\(numberOfComments)")
                }
                .padding(.leading)
                .padding(.bottom)
                
                Spacer()
                
                HStack {
                    Image(systemName: "at.circle.fill")
                    Text("\(author)")
                        .fontWeight(.bold)
                        .padding(.trailing, 5)
                }
                .padding(.trailing)
                .padding(.bottom)
                
                
            }
            .font(.subheadline)
            //            .padding(.top, 2.0)
        }
        .background(Color.primary.opacity(0.08))
        .cornerRadius(10)
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostView(postContent: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.", author: "JoeDoe", numberOfComments: 20)
                .previewLayout(.fixed(width: 400, height: 200))
            PostView(postContent: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.", author: "JoeDoe", numberOfComments: 20)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 400, height: 200))
        }
    }
}
