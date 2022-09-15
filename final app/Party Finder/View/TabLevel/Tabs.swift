//
//  Tabs.swift
//  Party Finder
//
//  Created by Alexandria Armknecht on 5/1/22.
//

import SwiftUI

struct Tabs: View {
    @EnvironmentObject var auth: Party_FinderAuth
    @EnvironmentObject var partyService: Party_FinderArticle
    
    @State var parties: [Party]
    @State var writing = false
    @State var error: Error?
    @State var fetching = false
    
    var body: some View {
        NavigationView {
            TabView {
                ListView(parties: $parties)
                    .tabItem {
                        Label("Parties", systemImage: "house.fill")
                    }
                MapView(parties: parties)
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
            }.navigationTitle("PartyFinder")
            .background(Color.blue)
            .navigationBarTitleDisplayMode(.inline).background(Color.gray)
                .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label : {
                        Label("", systemImage: "gearshape.2.fill")
                    }
                } 

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if (auth.user != nil) {
                        Button() {
                            writing = true
                        } label : {
                            Label("New", systemImage:"mappin.and.ellipse")
                                .labelStyle(.titleAndIcon)
                        }
                    }
                }
            }.background(Color.gray)
                .foregroundColor(Color.black)
        }.sheet(isPresented: $writing) {
            PartyEntry(parties: $parties, writing: $writing, user: auth.getCurrentUser())
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

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(parties: []).environmentObject(Party_FinderAuth())
            .environmentObject(Party_FinderArticle())
    }
}
