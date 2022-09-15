/**
 * EditView is a view for editing a party
 */
import SwiftUI

struct EditView: View {
    @EnvironmentObject var articleService: Party_FinderArticle
    @EnvironmentObject var model: Party_FinderArticle

    @Binding var parties: [Party]
    @Binding var party: Party
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Party Name")) {
                    TextField("", text: $party.partyName)
                }
                
                DatePicker("", selection: $party.time, in: Date.now...)
                    .labelsHidden()
                
                Section(header: Text("Rules")) {
                    TextEditor(text: $party.rules)
                        .frame(minHeight: 128, maxHeight: .infinity)
                }
                
                Section(header: Text("Address")) {
                    TextEditor(text: $party.address)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $party.notes)
                        .frame(minHeight: 128, maxHeight: .infinity)
                }
                
                Section(header: Text("Theme")) {
                    Picker("Tag", selection: $party.theme) {
                        ForEach(TagType.allCases.filter { $0 != TagType.all }, id: \.self) { tag in
                            Text(tag.rawValue).tag(tag.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Editing...")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        model.updateParty(party: party, partyName: party.partyName, address: party.address, rules: party.rules, notes: party.notes, theme: party.theme, time: party.time)
                        dismiss()
                    }
                }
            }
        }
    }
}
