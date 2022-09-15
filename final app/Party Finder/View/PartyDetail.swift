/**
 * ArticleDetail displays a single article model object.
 */
import SwiftUI

struct PartyDetail: View {
    @State var party: Party
    @State private var showWebView = false
    @State private var ratingToSubmit = 5
    @State private var angle: Double = 0
    
    @EnvironmentObject var auth: Party_FinderAuth
    @EnvironmentObject var model: Party_FinderArticle
    
    @Binding var parties: [Party]
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            PartyMetadata(party: party)
                .padding()

            VStack() {
                Text("Address").font(.headline)
                Text(party.address).frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)

            }.padding()
            
            VStack {
                Text("Party rules").font(.headline)
                Text(party.rules).frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
            }
            .padding()
            
            VStack {
                Text("Notes").font(.headline)
                Text(party.notes).frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
            }
            .padding()
            
            HStack {
                Text("Theme").font(.headline)
                Spacer()
                Text(party.theme)
            }
            .padding()
            
            HStack {
                Text("Overall Rating").font(.headline)
                Spacer()
                Text(calculateRating())
                Image(systemName:"star.bubble")
            }.padding()
            
            Spacer()
            
            if auth.getCurrentUser() == party.user {
                HStack{
                    Button("Delete") {
                        model.deleteParty(party: party)
                        parties = parties.filter { $0.id != party.id }
                    }
                    Spacer()
                    NavigationLink("Edit") {
                        EditView(parties: $parties, party: $party)
                    }
                }
                .padding()
            } else {
                VStack {
                    Text("How would you rate this party?")
                    HStack {
                        Picker("Rating", selection: $ratingToSubmit) {
                            Label("0 / 5", systemImage: "star").background(.red).tag(0)
                            Label("1 / 5", systemImage: "star").tag(1)
                            Label("2 / 5", systemImage: "star.leadinghalf.filled").tag(2)
                            Label("3 / 5", systemImage: "star.leadinghalf.filled").tag(3)
                            Label("4 / 5", systemImage: "star.fill").tag(4)
                            Label("5 / 5", systemImage: "star.fill").tag(5)
                        }.frame(width: 140, height: 40)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.orange, lineWidth: 3))
                            .background(.yellow.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
                        Button("Submit") {
                            angle += 360
                            model.updateRating(party: party, rating: party.rating + ratingToSubmit, numRatings: party.numRatings + 1)
                        }
                        .rotationEffect(.degrees(angle))
                        .animation(.spring(), value: angle)
                    }
                }.padding()
            }
        }
    }
    
    func calculateRating() -> String {
        if (party.numRatings == 0) {
            return "No ratings yet!"
        } else {
            return "\(party.rating/party.numRatings) / 5"
        }
    }
}

struct PartyDetail_Previews: PreviewProvider {
    @State static var partyTest = Party(id: "001",
                                        partyName: "Keckoween",
                                        address: "Keck Lab\nDoolan the Best Hall\n42069",
                                        rules: "Never removing the decorations",
                                        notes: "Boo",
                                        rating: 5,
                                        numRatings: 3,
                                        user: "Masao",
                                        theme: "Halloween",
                                             time: Date.now)
    @State static var parties: [Party] = [partyTest]
    
    static var previews: some View {
        PartyDetail(party: partyTest, parties: $parties).environmentObject(Party_FinderAuth()).environmentObject(Party_FinderArticle())
    }
}
