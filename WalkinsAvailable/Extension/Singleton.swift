//
//  Singleton.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import Foundation
import UIKit


class Singleton: NSObject {
    
    static var window: UIWindow?
    
    
    class func setHomeScreenView(userType: USER_TYPE) {
        let viewController = TabBarVC(userType: userType)
        viewController.selectedIndex  = 2
        let nav = NavigationController(rootViewController: viewController)
        nav.isNavigationBarHidden = true
        nav.tabBarController?.selectedIndex = 2
        Singleton.window?.rootViewController = nav
        Singleton.window?.makeKeyAndVisible()
    }
    
    class func setLoginScreenView() {
        let viewController = LoginVC()
        let nav = NavigationController(rootViewController: viewController)
        Singleton.window?.rootViewController = nav
        Singleton.window?.makeKeyAndVisible()
    }
    
    
}
