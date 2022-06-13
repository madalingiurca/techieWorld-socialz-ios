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
                            HStack {
                                PostCard(post: post, numberOfComments: 0)

                                NavigationLink(destination: PostDetails(post: post)) {
                                    EmptyView()
                                }
                                .frame(width: 0)
                                .opacity(0)
                            }
                            .listRowInsets(.init(top: 7,
                                                 leading: 10,
                                                 bottom: 7,
                                                 trailing: 3))
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .refreshable(action: {
                        dataSource.loadMoreContent()
                    })

                    NewPostButton(dataSource: dataSource)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Techiez")
        }
        .onAppear() {
            dataSource.loadMoreContent()
        }
        
    }
}


struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {

        let datasource = PostDataSource()
        datasource.posts = [
            Post(id: UUID.init(), author: "Mirel", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eros libero, faucibus a lobortis ac, egestas non lectus. Curabitur est nunc, interdum sed urna nec, facilisis posuere arcu. Phasellus vulputate odio turpis, ac accumsan nibh fermentum ut. Vivamus lobortis nulla urna, quis dapibus odio ullamcorper non."),
            Post(id: UUID.init(), author: "Tony", content: "Aenean dignissim laoreet mi."),
            Post(id: UUID.init(), author: "Tataie", content: "Quisque convallis maximus augue quis porttitor. Praesent vel sodales ex. Mauris consequat orci porttitor purus scelerisque molestie. Vivamus auctor ut ex ac molestie."),
            Post(id: UUID.init(), author: "Tataie", content: "Suspendisse at nisl felis. Sed fringilla purus vel nunc dapibus, in tincidunt neque fermentum. Donec viverra luctus pretium. Ut tincidunt, nunc in semper aliquet, elit turpis pulvinar mi, quis facilisis risus nunc non felis."),
            Post(id: UUID.init(), author: "Mirel", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eros libero, faucibus a lobortis ac, egestas non lectus. Curabitur est nunc, interdum sed urna nec, facilisis posuere arcu. Phasellus vulputate odio turpis, ac accumsan nibh fermentum ut. Vivamus lobortis nulla urna, quis dapibus odio ullamcorper non."),
            Post(id: UUID.init(), author: "Tony", content: "Aenean dignissim laoreet mi, a vulputate diam pellentesque tempus. Aenean eget tincidunt est. Nulla quis iaculis nibh, nec vulputate elit. Suspendisse placerat nunc tincidunt diam bibendum posuere. Quisque eget aliquam lorem. Aenean sodales dolor in dictum tempus. Donec sit amet mi mi."),
            Post(id: UUID.init(), author: "Tataie", content: "Quisque convallis maximus augue quis porttitor. Praesent vel sodales ex. Mauris consequat orci porttitor purus scelerisque molestie. Vivamus auctor ut ex ac molestie."),
            Post(id: UUID.init(), author: "Tataie", content: "Suspendisse at nisl felis. Sed fringilla purus vel nunc dapibus, in tincidunt neque fermentum. Donec viverra luctus pretium. Ut tincidunt, nunc in semper aliquet, elit turpis pulvinar mi, quis facilisis risus nunc non felis."),
        ]

        return Group {
            PostsListView(dataSource: datasource)
        }
    }
}


