//
//  article.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import Foundation

struct Article: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var date: Date
    static let genres = ["Action", "Romance", "Drama", "Comedy", "Horror"]
    var genre = 0
    var link: String
    var body: String
}
