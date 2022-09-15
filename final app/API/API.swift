//
//  API.swift
//  Party Finder
//
//  Created by Tanya on 5/4/22.
//

import Foundation

let API_KEY = "AIzaSyB6TRH9LQfHnygeUgKAwwbw2aTY5nTtUn8"
let GEOCODING_API_ROOT = "https://maps.googleapis.com/maps/api/geocode/json?"

enum APIError: Error {
    case unsuccessfulDecode
}

func getLocation(address: String) async throws -> Geocoding {
    let seperated = address.components(separatedBy: " ")
    let formattedAddress = seperated.joined(separator: "+")
    print(formattedAddress)
    guard let url = URL(string: "\(GEOCODING_API_ROOT)address=\(formattedAddress)&key=\(API_KEY)") else {
        fatalError("Should never happen, but just in case…URL didn’t work 😔")
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    if let decodedPage = try? JSONDecoder().decode(Geocoding.self, from: data) {
        return decodedPage
    } else {
        throw APIError.unsuccessfulDecode
    }
}
