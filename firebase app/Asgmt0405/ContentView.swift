//
//  ContentView.swift
//  Asgmt0405
//
//  Created by Sam Richard on 4/3/22.
//

import SwiftUI


struct ContentView: View {
    init() {
            UITableView.appearance().backgroundColor = .clear
        }
    var body: some View {
        Blog()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(movieBlogAuth())
    }
}
