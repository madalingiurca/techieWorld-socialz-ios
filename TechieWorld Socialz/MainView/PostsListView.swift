    //
    //  PostsListView.swift
    //  TechieWorld Socialz
    //
    //  Created by Madalin Giurca on 18.04.2022.
    //

import SwiftUI

struct PostsListView: View {

    @State var isViewingPostCreator = false
    @ObservedObject var dataSource: PostDataSource = PostDataSource()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    List {
                        ForEach(dataSource.posts, id: \.id) { post in
                            Section {
                                PostCard(postContent: post.content,
                                         author: post.author,
                                         numberOfComments: Int.random(in: 1..<100))
                                .padding(.horizontal)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .refreshable(action: {
                        dataSource.loadMoreContent()
                    })

                    NewPostButton(dataSource: dataSource)
                }
            }
        }
        .onAppear() {
            dataSource.loadMoreContent()
        }
        
    }
}


struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            PostsListView()
        }
    }
}


