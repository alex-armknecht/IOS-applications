//
//  TagType.swift
//  Party Finder
//
//  Created by Aidan Dionisio on 5/3/22.
//

import Foundation

enum TagType: String, Decodable, Encodable, CaseIterable {
    case all = "All"
    case none = "No Theme"
    case superheroes = "Superheroes"
    case disco = "Disco"
    case beach = "Beach"
    case summer = "Summer"
    case halloween = "Halloween"
    case paddy = "St. Patrick's Day"
    case luau = "Luau"
    case film = "Film/Pop Culture"
    case graduation = "Graduation"
    case space = "Space"
    case ninety = "90's"
    case celebrities = "Celebrities"
    case other = "Other"
}
