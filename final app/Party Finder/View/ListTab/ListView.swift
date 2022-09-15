//
//  ListView.swift
//  Party Finder
//
//  Created by Alexandria Armknecht on 5/1/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var auth: Party_FinderAuth
    
    @Binding var parties: [Party]
    
    var body: some View {
        Blog(parties: $parties)
    }
}

struct ListView_Previews: PreviewProvider {
    @State static var parties: [Party] = []
    
    static var previews: some View {
        ListView(parties: $parties)
    }
}
