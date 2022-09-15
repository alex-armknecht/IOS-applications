//
//  blog.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import SwiftUI

struct Blog: View {
    @EnvironmentObject var auth: movieBlogAuth
    @State var requestLogin = false

    var body: some View {
        if let authUI = auth.authUI {
            ArticleList(requestLogin: $requestLogin, articles: [])
                .sheet(isPresented: $requestLogin) {
                    AuthenticationViewController(authUI: authUI)
                }
        } else {
            VStack {
                Text("Sorry, looks like we aren’t set up right!")
                    .padding()
                Text("Please contact this app’s developer for assistance.")
                    .padding()
            }
        }
    }
}

struct Blog_Previews: PreviewProvider {
    static var previews: some View {
        Blog().environmentObject(movieBlogAuth())
    }
}
