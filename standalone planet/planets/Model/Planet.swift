import Foundation
import SwiftUI
import CoreLocation

struct Planet: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var isReal: Bool
    var isFavorite: Bool

    private var imageName: String
    
    var image: Image {
        Image(imageName)
            .resizable()
    }

}
