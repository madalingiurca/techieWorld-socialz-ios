//
//  PostDetails.swift
//  TechieWorld Socialz
//
//  Created by Bogdan Negoita on 11.06.2022.
//

import SwiftUI

struct PostDetails: View {
    var post: Post

    var body: some View {
        Text(post.content)
    }
}

struct PostDetails_Previews: PreviewProvider {
    static var previews: some View {
        PostDetails(post: Post(id: UUID.init(), author: "Tony", content: "Phasellus at commodo sapien. Vivamus sit amet turpis ut dolor consectetur sagittis. Etiam id vestibulum quam. Sed aliquet faucibus dui ut facilisis. Curabitur porta magna eget dapibus dapibus. Donec tempor aliquam elit, vitae gravida dui fermentum et. Donec lobortis imperdiet felis, eu congue risus mollis ut."))
    }
}
