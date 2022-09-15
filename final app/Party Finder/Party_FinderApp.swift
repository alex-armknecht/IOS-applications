//
//  Party_FinderApp.swift
//  Party Finder
//
//  Created by Aidan Dionisio on 4/24/22.
//

import SwiftUI

@main
struct Party_FinderApp: App {
    @UIApplicationDelegateAdaptor(Party_FinderAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Party_FinderAuth())
                .environmentObject(Party_FinderArticle())
                .preferredColorScheme(.light)
        }
    }
}
