/**
 * This defines the struct used to represent an individual party.
 */
import Foundation

struct Party: Hashable, Codable, Identifiable {
    var id: String
    var partyName : String
    var address : String
    var rules : String
    var notes : String
    var rating : Int
    var numRatings : Int
    var user : String
    var theme : String
    var time : Date
}
