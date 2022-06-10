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
    private var accessToken: String = ""
    
    var disposables = Set<AnyCancellable>()
    
    init() {
        // Get authToken from AuthManager
        if let token = AuthDetails.shared.token {
            self.accessToken = token
        }
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

    func createNewPost(_ content: String, done: @escaping () -> Void) {
        guard let url = URL(string: API.URL + "/posts/new") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "AUTHORIZATION")
        let newPostRequest = [
            "content": content
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: newPostRequest)

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 202 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Post.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in
                    print("Added new post.")
                    done()
                },
                receiveValue: { post in
                    self.posts.insert(post, at: self.posts.endIndex)
                }
            )
            .store(in: &disposables)
    }
    
    func loadMoreContent() {
        guard let url = URL(string: API.URL + "/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "AUTHORIZATION")
        
        URLSession.shared.dataTaskPublisher(for: request).tryMap() { element -> Data in
            return element.data
        }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .mapError { error in
            return error
        }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { debugPrint ("Received completion: \($0).") },
              receiveValue: { postings in
            self.posts = postings
        })
        .store(in: &disposables)
    }

    func setAccessToken(_ token: String) {
        self.accessToken = token
    }

}
