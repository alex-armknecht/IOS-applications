//
//  articleEntry.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import Foundation
import SwiftUI

struct ArticleEntry: View {
    @EnvironmentObject var articleService: movieBlogArticle

    @Binding var articles: [Article]
    @Binding var writing: Bool
    
    @State var title = ""
    @State var genre = 0
    @State var articleBody = ""
    @State var link = ""

    func submitArticle() {
        // We take a two-part approach here: this first part sends the article to
        // the database. The `createArticle` function gives us its ID.
        let articleId = articleService.createArticle(article: Article(
            id: UUID().uuidString, // Temporary, only here because Article requires it.
            title: title,
            date: Date(),
            genre: genre,
            link: link,
            body: articleBody
        ))

        // As an optimization, instead of reloading all of the entries again, we
        // just _add a new Article in memory_. This makes things appear faster and
        // if the database creation worked fine, upon the next load we would then
        // get the real stored Article.
        //
        // There is some risk here—in the event of an error we might mistakenly
        // provide the wrong impression that the Article was stored when it actually
        // wasn’t. More sophisticated code can look at the published `error` variable
        // in the article service and provide some feedback if that error becomes
        // non-nil.
        articles.append(Article(
            id: articleId,
            title: title,
            date: Date(),
            genre: genre,
            link: link,
            body: articleBody
        ))

        writing = false
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $title)
                }
                
                Picker("Genre", selection: $genre) {
                    ForEach(Article.genres.indices) {
                        Text(Article.genres[$0])                        
                    }
                }
                
                Section(header: Text("Link to watch:")) {
                    TextField("", text: $link)
                }
                
                Section(header: Text("Body")) {
                    TextEditor(text: $articleBody)
                        .frame(minHeight: 256, maxHeight: .infinity)
                }
            }
            .navigationTitle("New Article")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        writing = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitArticle()
                    }
                    .disabled(title.isEmpty || articleBody.isEmpty)
                }
            }
        }
    }
}

struct ArticleEntry_Previews: PreviewProvider {
    @State static var articles: [Article] = []
    @State static var writing = true
    
    static var previews: some View {
        ArticleEntry(articles: $articles, writing: $writing)
            .environmentObject(movieBlogArticle())
    }
}
