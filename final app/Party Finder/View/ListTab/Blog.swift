/**
 * The Blog view provides a top-level wrapper to check whether things are configured OK.
 */
import SwiftUI

struct Blog: View {
    @EnvironmentObject var auth: Party_FinderAuth
    @State var requestLogin = false
    
    @Binding var parties: [Party]

    var body: some View {
        if let authUI = auth.authUI {
            PartyList(requestLogin: $requestLogin, parties: $parties)
                .sheet(isPresented: $requestLogin) {
                    AuthenticationViewController(authUI: authUI)
                }
        } else {
            VStack {
                Text("Sorry, looks like we aren’t set up right!")
                    .padding()

                Text("Please contact this app’s developer for assistance.")
                    .padding()
            }
        }
    }
}

struct Blog_Previews: PreviewProvider {
    @State static var parties: [Party] = []
    
    static var previews: some View {
        Blog(parties: $parties).environmentObject(Party_FinderAuth())
    }
}
