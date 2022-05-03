//
//  TabBarVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

enum USER_TYPE {
    case user
    case business
    case serviceProvider
}


class TabBarVC: ESTabBarController {
    
    var attributesForTitle: [NSAttributedString.Key : Any] {
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
    }
    var currentController: UIViewController?
    var userType : USER_TYPE = .business

    
    init(userType: USER_TYPE) {
        super.init(nibName: nil, bundle: nil)
        self.userType = userType
        print(userType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setTabController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        switch userType {
        case .user:
            
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
            v5.type = "1"
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
            
        case .business:
            
            let v1 = EventVC()
            let v2 = BusinessFavouriteVC()
            let v3 = HomeVC()
            let v4 = BusinessNotificationVC()
            let v5 = AccountVC()
            
            v1.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Event", image: UIImage(named: "eventTab"), selectedImage: UIImage(named: "t"))
            v2.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Favourite", image:UIImage(named: "fav"), selectedImage: UIImage(named: "favSelected"))
                let image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysOriginal)
            v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: nil, image: image, selectedImage: image)
            v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Notification", image: UIImage(named: "nt"), selectedImage: UIImage(named: "ntSelected"))
            let img = UIImage(named: "pff")?.withRenderingMode(.alwaysOriginal)
            v5.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Account", image: img, selectedImage: img)
            v5.type = "2"
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
            
        case .serviceProvider:
            
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
            v5.type = "3"
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
        }
    }
    
    
}


class NavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.isHidden = true
    }
    
}


