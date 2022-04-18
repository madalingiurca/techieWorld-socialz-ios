//
//  PostsResponse.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

struct PostsResponse: Codable, Identifiable {
    var id: ObjectIdentifier
    
    var posts = [Post]()
    
    enum CodingKeys: String, CodingKey {
        case posts = "posts"
    }
}
