//
//  PostDataSource.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation
import Combine

class PostDataSource: ObservableObject {
    @Published var posts = [Post]()
    @Published var isLoadingPage = false
    private var canLoadMorePages = true
    private var accessToken: String;
    
    var disposables = Set<AnyCancellable>()
    
    init(accessToken: String) {
        self.accessToken = accessToken
        loadMoreContent()
    }
    
    func loadMoreContentIfNeeded(currentItem post: Post?) {
        guard let post = post else {
            loadMoreContent()
            return
        }
        
        let thresholdIndex = posts.index(posts.endIndex, offsetBy: -1)
        if posts.firstIndex(where: { $0.id == post.id }) == thresholdIndex {
            loadMoreContent()
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
//        guard let url = URL(string: "http://localhost:8080/posts") else { return }
        guard let url = URL(string: "http://20.229.185.66:8080/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "AUTHORIZATION")
        
        URLSession.shared.dataTaskPublisher(for: request).tryMap() { element -> Data in
            
            guard let httpResponse = element.response as? HTTPURLResponse
            else {
                throw URLError(.badServerResponse)
            }

            debugPrint("Error in calling TechieWorldAPI:")
            debugPrint(httpResponse.statusCode)
            
            return element.data
        }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .mapError { error in
            return error
        }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { debugPrint ("Received completion: \($0).") },
              receiveValue: { postings in
            debugPrint ("Response data: \(postings.debugDescription).")
            self.isLoadingPage = false
            self.posts = postings
        })
        .store(in: &disposables)
        
        //        URLSession.shared.dataTaskPublisher(for: url)
        //            .map(\.data)
        //            .decode(type: [Post].self, decoder: JSONDecoder())
        //            .receive(on: DispatchQueue.main)
        //            .handleEvents(receiveOutput: { response in
        //                self.isLoadingPage = false
        //            })
        //            .map({ fetchedPosts in
        //                return self.posts + fetchedPosts
        //            })
        //            .catch({ _ in Just(self.posts) })
        //            .assign(to: &$posts)
    }
}
