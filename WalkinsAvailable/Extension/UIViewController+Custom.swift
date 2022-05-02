//
//  UIViewController+Custom.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import Foundation
import UIKit


extension UIViewController {
    
    func push(viewController: UIViewController, animated: Bool = true) {
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    
}
