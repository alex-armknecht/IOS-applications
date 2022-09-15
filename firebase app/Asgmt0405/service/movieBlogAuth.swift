//
//  movieBlogAuth.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/3/22.
//

import Foundation
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI

class movieBlogAuth: NSObject, ObservableObject, FUIAuthDelegate {
    let authUI: FUIAuth? = FUIAuth.defaultAuthUI()
    

    // Multiple providers can be supported! See: https://firebase.google.com/docs/auth/ios/firebaseui
    @Published var user: User?

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
      if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
        return true
      }
      // other URL handling goes here.
      return false
    }
    /**
     * You might not have overriden a constructor in Swift before...well, here it is.
     */
    override init() {
        super.init()
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(authUI: authUI!),
            FUIEmailAuth()
        ]

        // Note that authUI is marked as _optional_. If things don’t appear to work
        // as expected, check to see that you actually _got_ an authUI object from
        // the Firebase library.
        authUI?.delegate = self
        authUI?.providers = providers
    }
    

    /**
     * In another case of the documentation being somewhat behind the latest libraries,
     * this delegate method:
     *
     *     func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?)
     *
     * …has been deprecated in favor of the one below.
     */
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let actualResult = authDataResult {
            user = actualResult.user
        }
    }

    func signOut() throws {
        try authUI?.signOut()

        // If we get past the logout attempt, we can safely clear the user.
        user = nil
    }
}

