//
//  DogAPI.swift
//  DogvsDog
//
//  Created by zan on 3/11/22.
//

import Foundation

enum DogError: Error {
    case invalidDecode
    case invalidURL
}

let api_key = "53e41bcd-c509-4f5a-87e1-f74291d7bb75"
let api_root = "https://api.thedogapi.com/v1/images/search"
let api_testdog = "https://api.thedogapi.com/v1/images/0M8mDvUgF"

func getRandomDog() async throws -> Dog {
    guard let url = URL(string: api_root) else {
        throw DogError.invalidURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedDog = try? JSONDecoder().decode([Dog].self, from: data) {
        return decodedDog[0]
    } else {
        throw DogError.invalidDecode
    }
}

