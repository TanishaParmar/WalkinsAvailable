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
import UserNotifications
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
        getNotificationBadgeCountData()
        self.configureKeboard()
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
        
//        registerForPushNotifications()
        configureNotification(application: application)
        LocationManager.shared.getLocation()
        
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
    
    
    func configureNotification(application: UIApplication) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }else{
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }


    func getCategoryListData() {
        ApiHandler.updateProfile(apiName: API.Name.categoriesList, params: [:]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: CategoryListModel.self) {
                    if let data = response.data {
                        Singleton.shared.categoryList = data
                        Singleton.shared.callBackCategoryListing?()
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                }
            }
        }
    }

    
    func getNotificationBadgeCountData() {
        if let userId = UserDefaultsCustom.getUserData()?.userId {
            let type = UserDefaultsCustom.getLoginRole(key: userId)
            let role = UserDefaultsCustom.getLoginRole(key: userId).role
            switch type {
            case .user, .business:
                ApiHandler.updateProfile(apiName: API.Name.getNotificationBadgeCount, params: ["role": role]) { succeeded, response, data in
                    print("response data ** \(response)")
                    ActivityIndicator.sharedInstance.hideActivityIndicator()
                    if succeeded {
                        if let badgeCount = response["badgeCount"] as? String {
                            Singleton.shared.notificationBadgeCount = badgeCount
                            Singleton.shared.callBackBadgeCount?()
                        }
                    } else {
                        if let msg = response["message"] as? String {
                        }
                    }
                }
            case .serviceProvider:
                break
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
    
    
    func handleNotificationRedirection(data: [String : Any]) {
        var logInRole: USER_TYPE = .user
        if let userId = UserDefaultsCustom.getUserData()?.userId {
            logInRole = UserDefaultsCustom.getLoginRole(key: userId)
            print("logIn Role", logInRole)
        }
        let notificationType = data["notificationType"] as? String ?? ""
        if notificationType == "1" || notificationType == "2" || notificationType == "3" {
            switch logInRole {
            case .user:
                break
            case .business:
                let rootVc = TabBarVC()
                rootVc.selectedIndex = 3
                let nav =  UINavigationController(rootViewController: rootVc)
                nav.isNavigationBarHidden = true
                
                if #available(iOS 13.0, *) {
                    if let scene = UIApplication.shared.connectedScenes.first {
                        let windowScene = (scene as? UIWindowScene)
                        print(">>> windowScene: \(windowScene)")
                        let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                        window.windowScene = windowScene //Make sure to do this
                        window.rootViewController = nav
                        window.makeKeyAndVisible()
                        self.window = window
                    }
                } else {
                    self.window?.rootViewController = nav
                    self.window?.makeKeyAndVisible()
                }
                break
            case .serviceProvider:
                let rootVc = TabBarVC()
                    rootVc.selectedIndex = 2

                let nav =  UINavigationController()
                nav.viewControllers = [rootVc, ServiceNotificationVC()]
                nav.isNavigationBarHidden = true

                if #available(iOS 13.0, *){
                    if let scene = UIApplication.shared.connectedScenes.first {
                        let windowScene = (scene as? UIWindowScene)
                        print(">>> windowScene: \(windowScene)")
                        let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                        window.windowScene = windowScene //Make sure to do this
                        window.rootViewController = nav
                        window.makeKeyAndVisible()
                        self.window = window
                    }
                } else {
                    self.window?.rootViewController = nav
                    self.window?.makeKeyAndVisible()
                }

            }
        }
        print(data)
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




//MARK:- Push notifications method(s)
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(print("didReceive response"), response.notification.request.content.userInfo)
        
        let userInfo = response.notification.request.content.userInfo
        if let aps = userInfo["aps"] as? [String: Any] {
            if let notifyData = aps["data"] as? [String:Any] {
                handleNotificationRedirection(data: notifyData)
            }
        }
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("device token string ***", deviceTokenString)
        UserDefaultsCustom.saveDeviceToken(userToken: deviceTokenString)
        //        Globals.defaults.set(deviceTokenString, forKey: DefaultKeys.deviceToken)
    }

    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
  
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
        let userDict = userInfo as! [String:Any]
        print("received", userDict)
        if application.applicationState == .inactive{

        }else{
            print("not invoked cause its in foreground")
        }
        completionHandler(.newData)
    }
        
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
        completionHandler([.sound,.alert, .badge])
    }
}
