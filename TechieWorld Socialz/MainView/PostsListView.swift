//
//  PostsListView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 18.04.2022.
//

import SwiftUI

struct PostsListView: View {
    
    @StateObject var dataSource : PostDataSource
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        ForEach(dataSource.posts, id: \.id) { post in
                            NavigationLink(destination: {
                                Text("WIP: Post will be here")
                            }) {
                                PostView(postContent: post.content, author: post.author, numberOfComments: Int.random(in: 1..<100))
                                    .task {
                                        dataSource.loadMoreContentIfNeeded(currentItem: post)
                                    }
                                    .padding(.horizontal)
                            }
                            .navigationBarHidden(true)
                            .accentColor(.primary)
                        }
                        
                        if dataSource.isLoadingPage {
                            ProgressView()
                        }
                    }
                    .refreshable(action: {
                        debugPrint("Posts refreshed.")
                    })
                }
                FloatingButton()
            }
        }
    }
}


struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        let datasource = PostDataSource(accessToken: "access-token")
        datasource.posts.append(Post(id: 1, author: "Jonutzu", content: "Morbi sit amet vestibulum nisl. Quisque consectetur, nibh ac fermentum rhoncus, nulla mi porttitor nisl, eget faucibus nisi nulla id magna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. "))
        datasource.posts.append(Post(id: 2, author: "LeeSin", content: "In eget lectus eget nunc luctus mattis. Nunc ac odio dictum, dignissim metus vitae, tempus nunc. Phasellus nec lobortis dui. Nulla iaculis, velit a faucibus ultricies, lorem eros finibus elit, at condimentum nulla metus tempus magna. In id tempus diam. Cras volutpat sapien et arcu dictum ullamcorper."))
        datasource.posts.append(Post(id: 3, author: "hotter", content: "Nulla dolor enim, fringilla vel elit eget, pulvinar convallis sapien. Nullam non auctor mi, ut maximus urna. Vestibulum faucibus sit amet erat vitae pellentesque. Curabitur et accumsan velit. Cras enim sem, auctor sed diam vitae, porttitor commodo nulla. Nullam id elit ut felis sagittis congue. Vestibulum sodales dolor eu augue tincidunt, eget consectetur mi vulputate. Morbi et quam nunc. Donec sagittis in velit sit amet suscipit. Morbi a dolor at est placerat suscipit in non felis. Praesent egestas enim quis mi vestibulum, eu pellentesque enim faucibus. Nulla maximus purus vitae ante condimentum, eu lobortis velit suscipit. Phasellus id purus quam. Vivamus nulla purus, laoreet in ex non, tincidunt suscipit diam. Curabitur tincidunt eros elit, vel dapibus nulla laoreet sit amet."))
        datasource.isLoadingPage = false
        
        return PostsListView(dataSource: datasource)
    }
}
