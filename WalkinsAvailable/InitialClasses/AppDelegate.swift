//
//  AppDelegate.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/2/22.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FacebookLogin
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var categoryList: [CategoryList]?
    
    private func configureKeboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIScrollView.self,UIView.self,UITextField.self,UITextView.self,UIStackView.self]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(2)
        
        getCategoryListData()
        self.configureKeboard()
        LocationManager.shared.getLocation()
        // Override point for customization after application launch.
//        appFonts()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        Singleton.window = self.window
        
        let token = ""
        if token.count > 0 {
            Singleton.setHomeScreenView()
        } else {
            Singleton.setLoginScreenView()
        }
        
        
        
        FBSDKCoreKit.ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        
        GIDSignIn.sharedInstance().clientID = "169642617507-d96ffhvh2f5u00912gdjki9gie8638kk.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]) {
            return true
        }
        if (GIDSignIn.sharedInstance().handle(url)) {
            return true
        } else if (ApplicationDelegate.shared.application(app, open: url, options: options)) {
            return true
        }
        return false
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("device token string", deviceTokenString)
//        Globals.defaults.set(deviceTokenString, forKey: DefaultKeys.deviceToken)
    }
    

    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
////        return GIDSignIn.sharedInstance().handle(url)
//        if let isFBOpenUrl = SDKApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
//            return true
//        }
//        if let isGoogleOpenUrl = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation) {
//            return true
//        }
//        return false
//    }
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//
//        if ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]) {
//            return true
//        }
//
//        if ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
//            return true
//        }
//        if GIDSignIn.sharedInstance().handle(url) { // GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation) {
//            return true
//        }
//        return false
//    }


    func getCategoryListData() {
        ApiHandler.updateProfile(apiName: API.Name.categoriesList, params: [:]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: CategoryListModel.self) {
                    if let data = response.data {
                        Singleton.shared.categoryList = data
                    }
                }
//                Singleton.shared.showErrorMessage(error: "success", isError: .success)
            } else {
                if let msg = response["message"] as? String {
//                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }

    
    func appFonts() {
        for family in UIFont.familyNames {
          let sName: String = family as String
          print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
          }
        }
    }


}


extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                //                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        } else {
            debugPrint("user info =>", user?.profile)
        }
        
        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil, userInfo: ["googleUserInfo": user])
    }
}

// MARK:- Notification names
extension Notification.Name {
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}
