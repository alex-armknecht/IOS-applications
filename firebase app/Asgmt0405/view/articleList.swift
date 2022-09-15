//
//  articleList.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import SwiftUI
import Firebase

struct ArticleList: View {
    @EnvironmentObject var auth: movieBlogAuth
    @EnvironmentObject var articleService: movieBlogArticle

    @Binding var requestLogin: Bool
    
    private let db = Firestore.firestore()
    
    @State var articles: [Article]
    @State var error: Error?
    @State var fetching = false
    @State var writing = false
    @State var ngenre = 0

    
    var body: some View {
        NavigationView {
            Image("movieBackGround")
                .resizable()
                .frame(maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(alignment: .center) {
                        if fetching {
                            ProgressView()
                        } else if error != nil {
                            Text("Something went wrong…we wish we can say more 🤷🏽")
                        } else if articles.count == 0 {
                            VStack {
                                Spacer()
                                Text("There are no articles.")
                                Spacer()
                            }
                        } else {
                            
                            Picker("Genre", selection: $ngenre) {
                                ForEach(Article.genres.indices) {
                                    Text(Article.genres[$0])
                                }
                            }
                        
                        
                            
                            
                            List(articles.filter{ $0.genre != ngenre }) { article in
                                NavigationLink {
                                    ArticleDetail(article: article, articles: $articles)
                                } label: {
                                    ArticleMetadata(article: article)
                                }
                            }
                        }
                    }
                    .navigationTitle("Alpha🎥")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            if auth.user != nil {
                                Button("New Article") {
                                    writing = true
                                }
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            if auth.user != nil {
                                Button("Sign Out") {
                                    do {
                                        try auth.signOut()
                                    } catch {
                                        // No error handling in the sample, but of course there should be
                                        // in a production app.
                                    }
                                }
                            } else {
                                Button("Sign In") {
                                    requestLogin = true
                                }
                            }
                        }
                    }
                )
        }
        .sheet(isPresented: $writing) {
            ArticleEntry(articles: $articles, writing: $writing)
        }
        .task {
            fetching = true

            do {
                articles = try await articleService.fetchArticles()
                fetching = false
            } catch {
                self.error = error
                fetching = false
            }
        }
    }
}

struct ArticleList_Previews: PreviewProvider {
    @State static var requestLogin = false

    static var previews: some View {
        ArticleList(requestLogin: $requestLogin, articles: [])
            .environmentObject(movieBlogAuth())

        ArticleList(requestLogin: $requestLogin, articles: [
            Article(
                id: "12345",
                title: "Preview",
                date: Date(),
                link: "https://www.amazon.com/Amazon-Video/b?ie=UTF8&node=7589478011",
                body: "Lorem ipsum dolor sit something something amet"
            ),

            Article(
                id: "67890",
                title: "Some time ago",
                date: Date(timeIntervalSinceNow: TimeInterval(-604800)),
                link: "https://www.amazon.com/Amazon-Video/b?ie=UTF8&node=7589478011",
                body: "Duis diam ipsum, efficitur sit amet something somesit amet"
            )
        ])
        .environmentObject(movieBlogAuth())
        .environmentObject(movieBlogArticle())
    }
}
