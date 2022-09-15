/**
 * ArticleEntry is a view for creating a new article.
 */
import SwiftUI

struct PartyEntry: View {
    @EnvironmentObject var partyService: Party_FinderArticle
    @EnvironmentObject var auth: Party_FinderAuth

    @Binding var parties: [Party]
    @Binding var writing: Bool
    let user: String
    
    @State var partyName = ""
    @State var address = ""
    @State var rules = ""
    @State var notes = ""
    @State var theme = TagType.none.rawValue
    
    @State private var partyDate = Date()
    
    func submitParty() {
        // We take a two-part approach here: this first part sends the article to
        // the database. The `createArticle` function gives us its ID.
        let partyId = partyService.createParty(party: Party(
            id: UUID().uuidString, // Temporary, only here because Article requires it.
            partyName: partyName,
            address: address,
            rules: rules,
            notes: notes,
            rating: 0,
            numRatings: 0,
            user: user,
            theme: theme,
            time: partyDate
        ))

        // As an optimization, instead of reloading all of the entries again, we
        // just _add a new Article in memory_. This makes things appear faster and
        // if the database creation worked fine, upon the next load we would then
        // get the real stored Article.
        //
        // There is some risk here—in the event of an error we might mistakenly
        // provide the wrong impression that the Article was stored when it actually
        // wasn’t. More sophisticated code can look at the published `error` variable
        // in the article service and provide some feedback if that error becomes
        // non-nil.
        parties.append(Party(
            id: partyId,
            partyName: partyName,
            address: address,
            rules: rules,
            notes: notes,
            rating: 0,
            numRatings: 0,
            user: user,
            theme: theme,
            time: partyDate
        ))

        writing = false
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Party Name")) {
                    TextField("", text: $partyName)
                }
                
                DatePicker("", selection: $partyDate, in: Date.now...)
                    .labelsHidden()
                
                Section(header: Text("Address")) {
                    TextEditor(text: $address)
                }
                
                Section(header: Text("Rules")) {
                    TextEditor(text: $rules)
                        .frame(minHeight: 128, maxHeight: .infinity)
                }
                
                Section(header: Text("Theme")) {
                    Picker("Tag", selection: $theme) {
                        ForEach(TagType.allCases.filter { $0 != TagType.all }, id: \.self) { tag in
                            Text(tag.rawValue).tag(tag.rawValue)
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 128, maxHeight: .infinity)
                }
            }
            .navigationTitle("New Party")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        writing = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitParty()
                    }
                    .disabled(partyName.isEmpty || rules.isEmpty)
                }
            }
        }
    }
}
