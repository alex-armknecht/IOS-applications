/**
 * ArticleMetadata is a view that displays side information about its given article.
 */
import SwiftUI

struct PartyMetadata: View {
    var party: Party

    var body: some View {
        HStack() {
            Text(party.partyName)
                .font(.headline)

            Spacer()

            VStack(alignment: .trailing) {
                HStack {
                    Text(party.time, style: .date)
                    Text("|")
                    Text(party.time, style: .time)
                }
                Text(party.theme)
            }.font(.caption)
        }
    }
}
