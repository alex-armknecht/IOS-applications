//
//  Asgmt0405App.swift
//  Asgmt0405
//
//  Created by Sam Richard on 4/3/22.
//

import SwiftUI

@main
struct Asgmt0405App: App {
    // This connects our newfangled SwiftUI app with the UIApplicationDelegate
    // object mentioned in the Firebase documentation.
    @UIApplicationDelegateAdaptor(movieBlogAppDelegate.self) var appDelegate
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieBlogAuth())
                .environmentObject(movieBlogArticle())
        }
    }
}
