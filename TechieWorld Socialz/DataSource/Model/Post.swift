//
//  Post.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: CLong
    var author: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case content = "content"
    }
}
