//
//  GoogleManager.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/27/22.
//

import UIKit
import GoogleSignIn

typealias googleResponse = (_ userId:String?, _ fullName: String?, _ email : String?, _ idToken : String? , _ profilePicture : URL?) -> ()
typealias googleFailureResponse = (_ error:String?) -> ()

class GoogleManager: NSObject {

    private var viewController:UIViewController?
    private var success: googleResponse?
    private var failure: googleFailureResponse?
    
    
    static let shared = GoogleManager()
    
    func googleSignIn(controller:UIViewController, success: @escaping googleResponse, failure: @escaping googleFailureResponse){
        // ActivityIndicator.sharedInstance.showActivityIndicator()
      
        self.viewController = controller
        self.success = success
        self.failure = failure
        
        GIDSignIn.sharedInstance()?.presentingViewController = controller
        GIDSignIn.sharedInstance().clientID = "169642617507-d96ffhvh2f5u00912gdjki9gie8638kk.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    
}


extension GoogleManager: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Check for sign in error
        if let error = error {
            self.failure?(error.localizedDescription)
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                //                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        } else {
            debugPrint("user info =>", user?.profile)
            // Post notification after user successfully sign in
            
            let user = signIn.currentUser
            
            self.success?(user?.userID, user?.profile?.name, user?.profile?.email, user?.authentication.idToken, user?.profile?.imageURL(withDimension: 500))
        }
    }
    
}
