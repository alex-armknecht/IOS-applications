//
//  movieBlogAppDelegate.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import Foundation
import UIKit

// As a personal preference, I tend to put third-party library imports after the
// first-party iOS ones just so I know who’s responsible for what.
import Firebase

class movieBlogAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
