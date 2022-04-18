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
        ScrollView {
              LazyVStack {
                ForEach(dataSource.posts) { post in
                  Text(post.content)
                    .onAppear {
                      dataSource.loadMoreContentIfNeeded(currentItem: post)
                    }
                    .padding(.all, 30)
                }

                if dataSource.isLoadingPage {
                  ProgressView()
                }
              }
            }
    }
}


struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        let datasource = PostDataSource(accessToken: "access-token")
        datasource.posts.append(Post.init(id: 3, author: "madalin", content: "Morbi sit amet vestibulum nisl. Quisque consectetur, nibh ac fermentum rhoncus, nulla mi porttitor nisl, eget faucibus nisi nulla id magna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. "))
        datasource.posts.append(Post.init(id: 1, author: "", content: "n eget lectus eget nunc luctus mattis. Nunc ac odio dictum, dignissim metus vitae, tempus nunc. Phasellus nec lobortis dui. Nulla iaculis, velit a faucibus ultricies, lorem eros finibus elit, at condimentum nulla metus tempus magna. In id tempus diam. Cras volutpat sapien et arcu dictum ullamcorper."))
        datasource.isLoadingPage = false
        
        return PostsListView(dataSource: datasource)
    }
}
