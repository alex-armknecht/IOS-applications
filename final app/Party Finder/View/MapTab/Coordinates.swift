//
//  Coordinates.swift
//  Party Finder
//
//  Created by Tanya on 5/4/22.
//

import Foundation

struct Coordinates: Hashable, Codable {
    var lat: Double
    var lng: Double
}

struct Location: Hashable, Codable {
    var location: Coordinates
}

struct Geometry: Hashable, Codable {
    var geometry: Location
}

struct Geocoding: Hashable, Codable {
    var results: [Geometry]
    var status: String
}

