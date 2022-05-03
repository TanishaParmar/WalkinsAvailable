//
//  AppHelperMethods.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/2/22.
//

import UIKit

class AppHelperMethods: NSObject {
    
    class func navigateToHomeScreen(window: UIWindow?) {
        let viewController = SignUpAsVC()
        viewController.view.backgroundColor = .gray
        let nav = UINavigationController(rootViewController: viewController)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    class func set(window: UIWindow?) {
        let viewController = LoginVC()
        viewController.view.backgroundColor = .gray
        let nav = UINavigationController(rootViewController: viewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    
    
    
}
