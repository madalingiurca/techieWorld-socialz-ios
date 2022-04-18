//
//  SwiftUIView.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 17.04.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        ZStack {
            PostsListView(dataSource: PostDataSource(accessToken: authentication.accessToken))
            HStack {
                VStack {
                    Spacer()
                    ZStack{
                        Button(action: {
                            authentication.accessToken = ""
                            authentication.isAuthenticated = false
                        })
                        {
                            Circle()
                                .foregroundColor(Color("pink"))
                                .frame(width: 60, height: 60)
                        }
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding(5)
                }
                Spacer()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let auth = Authentication();
        auth.isAuthenticated = true
        auth.accessToken = "my-access-token"
        
        return MainView()
            .environmentObject(auth)
    }
}
