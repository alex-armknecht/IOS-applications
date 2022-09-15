//
//  articleDetail.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import Foundation
import SwiftUI
import Firebase

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
                )
    }
}

struct ArticleDetail: View {
    private let db = Firestore.firestore()
    
    var article: Article
    @Binding var articles: [Article]
    @State private var showWebView = false
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            
            VStack {
                
                ArticleMetadata(article: article)
            
                Divider()
                
                HStack {
                    Button {
                        showWebView.toggle()
                    } label: {
                        Text("Watch Movie")
                    }
                    .sheet(isPresented: $showWebView) {
                        WebView(url: URL(string: article.link)!)
                    }
                    
                    Spacer()
                                        
                    Button {
                        showDetail.toggle()
                        
                        withAnimation {
                            
                                                        
                            db.collection("articles").document(article.id).delete() { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    articles.removeAll(where: {article.id == $0.id})
                                    print("Document successfully removed!")
                                }
                            }
                            
                        }
                    } label: {
                        Label("Graph", systemImage: "trash")
                            .foregroundColor(.red)
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                            .rotationEffect(.degrees(showDetail ? 180 : 0))
                            .scaleEffect(showDetail ? 1.5 : 1)
                            .padding()
                    }
                    
                }
            }
            .padding()
        
            
            Text(article.body)
                .padding()
            
            
            if showDetail {
                Text(article.body)
                    .transition(.moveAndFade)
            }
            
            
            Spacer()
            
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    @State static var articles: [Article] = []
    static var previews: some View {
        ArticleDetail(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            link: "https://www.amazon.com/Amazon-Video/b?ie=UTF8&node=7589478011",
            body: "Lorem ipsum dolor sit something something amet"
            
        ),articles:$articles)
        
    }
}
