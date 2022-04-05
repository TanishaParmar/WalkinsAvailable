//
//  TabBarVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit


class TabBarVC: ESTabBarController {
    
    var attributesForTitle: [NSAttributedString.Key : Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
    }
    var currentController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabController()
    }
    
    func setTabController() {
        self.tabBar.backgroundColor = .white
        self.tabBar.addCornerBorderAndShadow(view: self.tabBar, cornerRadius: 0, shadowColor: .lightGray, borderColor: .clear, borderWidth: 0.0)

//        self.shouldHijackHandler = { (tabbarController, viewController, index) in
//            return index == 2
//        }
//        self.didHijackHandler = { (tabbarController, viewController, index) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                if let navController = tabbarController.selectedViewController as? UINavigationController {
//                    self.currentController = navController.visibleViewController
//                }
//            }
//        }
        
        let v1 = ChatListVC()
        let v2 = FavouriteVC()
        let v3 = HomeVC()
        let v4 = NotificationVC()
        let v5 = AccountVC()
        
        
        v1.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Chat", image: UIImage(named: "chat"), selectedImage: UIImage(named: "chatSelected"))
        v2.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Favourite", image:UIImage(named: "fav"), selectedImage: UIImage(named: "favSelected"))
            let image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysOriginal)
        v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: nil, image: image, selectedImage: image)
        v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Notification", image: UIImage(named: "nt"), selectedImage: UIImage(named: "ntSelected"))
        let img = UIImage(named: "pff")?.withRenderingMode(.alwaysOriginal)
        v5.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Account", image: img, selectedImage: img)
        
        self.viewControllers = [v1, v2, v3, v4, v5]
        
    }
    
    
}


