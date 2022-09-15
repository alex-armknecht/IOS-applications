//
//  ContentView.swift
//  Party Finder
//
//  Created by Aidan Dionisio on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = UIColor(red: 214.0 / 255, green: 214 / 255, blue: 245.0 / 255, alpha: 1.0)
        }
    var body: some View {
        Tabs(parties:[])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Party_FinderAuth())
    }
}
