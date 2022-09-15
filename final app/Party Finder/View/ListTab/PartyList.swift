/**
 * ArticleList displays a list of articles, toggling between the list and a chosen article.
 */
import SwiftUI

struct PartyList: View {
    @EnvironmentObject var auth: Party_FinderAuth
    @EnvironmentObject var partyService: Party_FinderArticle

    @Binding var requestLogin: Bool
    @Binding var parties: [Party]
    
    @State var error: Error?
    @State var fetching = false
    @State var value = TagType.all
    
    var filteredParties: [Party] {
        switch value {
        case TagType.all:
            return parties
        default:
            return parties.filter { $0.theme == value.rawValue}
        }
    }
    
    var body: some View {
        VStack {
            Picker("Theme", selection: $value){
                ForEach(TagType.allCases, id: \.self) { tag in
                    Text(tag.rawValue).tag(tag)
                }
            }
            Spacer()
            if fetching {
                ProgressView()
            } else if error != nil {
                Text("Something went wrong…we wish we can say more 🤷🏽")
            } else
            if parties.count == 0 {
                VStack {
                    Spacer()
                    Text("There are no parties :(")
                    Spacer()
                }
            } else {
                List(filteredParties) { party in
                    NavigationLink {
                        PartyDetail(party: party, parties: $parties)
                    } label: {
                        PartyMetadata(party: party)
                    }
                }
            }
        }
        .task {
            fetching = true

            do {
                parties = try await partyService.fetchParties()
                fetching = false
            } catch {
                self.error = error
                fetching = false
            }
        }
    }
}
