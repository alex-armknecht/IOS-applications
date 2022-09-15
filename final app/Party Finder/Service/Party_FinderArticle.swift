/**
 * Party_FinderAppArticle is the article service—it completely hides the data store from the rest of the app.
 * No other part of the app knows how the data is stored. If anyone wants to read or write data, they have
 * to go through this service.
 */
import Foundation

import Firebase

let COLLECTION_NAME = "parties"
let PAGE_LIMIT = 20

enum ArticleServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class Party_FinderArticle: ObservableObject {
    private let db = Firestore.firestore()

    // Some of the iOS Firebase library’s methods are currently a little…odd.
    // They execute synchronously to return an initial result, but will then
    // attempt to write to the database across the network asynchronously but
    // not in a way that can be checked via try async/await. Instead, a
    // callback function is invoked containing an error _if it happened_.
    // They are almost like functions that return two results, one synchronously
    // and another asynchronously.
    //
    // To deal with this, we have a published variable called `error` which gets
    // set if a callback function comes back with an error. SwiftUI views can
    // access this error and it will update if things change.
    @Published var error: Error?
    
    func updateParty(party: Party, partyName: String, address: String, rules: String, notes: String, theme: String, time: Date) {
        db.collection(COLLECTION_NAME).document(party.id).updateData([
            "partyName": partyName,
            "address": address,
            "rules": rules,
            "notes": notes,
            "theme": theme,
            "time": time
        ])
    }
    
    func deleteParty(party: Party) {
        db.collection(COLLECTION_NAME).document(party.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func updateRating(party: Party, rating: Int, numRatings: Int) {
        db.collection(COLLECTION_NAME).document(party.id).updateData([
            "rating": rating,
            "numRatings": numRatings
        ])
    }
    
    func createParty(party: Party) -> String {
        var ref: DocumentReference? = nil

        // addDocument is one of those “odd” methods.
        ref = db.collection(COLLECTION_NAME).addDocument(data: [
            "id": party.id,
            "partyName": party.partyName,
            "time": party.time, // This gets converted into a Firestore Timestamp.
            "address": party.address,
            "rules": party.rules,
            "notes": party.notes,
            "rating": party.rating,
            "numRatings": party.numRatings,
            "user": party.user,
            "theme": party.theme
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }

        // If we don’t get a ref back, return an empty string to indicate “no ID.”
        return ref?.documentID ?? ""
    }

    // Note: This is quite unsophisticated! It only gets the first PAGE_LIMIT articles.
    // In a real app, you implement pagination.
    func fetchParties() async throws -> [Party] {
        let articleQuery = db.collection(COLLECTION_NAME)
            .order(by: "time", descending: true)
            .limit(to: PAGE_LIMIT)

        // Fortunately, getDocuments does have an async version.
        //
        // Firestore calls query results “snapshots” because they represent a…wait for it…
        // _snapshot_ of the data at the time that the query was made. (i.e., the content
        // of the database may change after the query but you won’t see those changes here)
        let querySnapshot = try await articleQuery.getDocuments()

        return try querySnapshot.documents.map {
            // This is likely new Swift for you: type conversion is conditional, so they
            // must be guarded in case they fail.
            guard let partyName = $0.get("partyName") as? String,

                // Firestore returns Swift Dates as its own Timestamp data type.
                let dateAsTimestamp = $0.get("time") as? Timestamp,
                let address = $0.get("address") as? String ,
                  let rules = $0.get("rules") as? String ,
                  let notes = $0.get("notes") as? String ,
                  let rating = $0.get("rating") as? Int ,
                  let numRatings = $0.get("numRatings") as? Int ,
                  let user = $0.get("user") as? String ,
                let theme = $0.get("theme") as? String else {
                throw ArticleServiceError.mismatchedDocumentError
            }

            return Party(
                id: $0.documentID,
                partyName: partyName,
                address: address,
                rules: rules,
                notes: notes,
                rating: rating,
                numRatings: numRatings,
                user: user,
                theme: theme,
                time: dateAsTimestamp.dateValue()
            )
        }
    }
}
