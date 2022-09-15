//
//  articleMetadata.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import SwiftUI

struct ArticleMetadata: View {
    var article: Article

    var body: some View {
        HStack() {
            VStack {
                Text(article.title)
                    .font(.title)
                
                //Text(article.genre)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(article.date, style: .date)
                    .font(.caption)

                Text(article.date, style: .time)
                    .font(.caption)
            }
        }
    }
}

struct ArticleMetadata_Previews: PreviewProvider {
    static var previews: some View {
        ArticleMetadata(article: Article(
            id: "12345",
            title: "Preview",
            date: Date(),
            link: "https://www.amazon.com/Amazon-Video/b?ie=UTF8&node=7589478011",
            body: "Lorem ipsum dolor sit something something amet"
        ))
    }
}
