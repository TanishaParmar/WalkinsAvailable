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

enum Account_Type: String {
    case switchAccountAsUser = "Switch account as user"
    case switchAccountAsBussiness = " Switch account as business"
    case switchAccountAsServiceProvider = "Switch account as Service provider"
    case setAvailability = "Set Availability"
    case requestInvitesForShops = "Request invites for shops"
    case aboutUs = "About Us"
    case contactUs = "Contact Us"
    case complaints = "Complaints"
    case changePassword = "Change Password"
    case logout = "logout"
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
        self.tabBar.frame.size.height = 40
        tabBar.frame.origin.y = view.frame.height - 40
//        self.setTabController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setTabController()
        self.tabBar.isHidden = false
        self.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame: CGRect = self.tabBar.frame
        tabFrame.size.height += 10
        tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
        self.tabBar.frame = tabFrame
        print("set ************** ")
        addRedDotAtTabBarItemIndex(index: 0)
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        addRedDotAtTabBarItemIndex(index: item.tag)
    }
    
    func setTabController() {
        self.tabBar.backgroundColor = .white
        self.tabBar.addCornerBorderAndShadow(view: self.tabBar, cornerRadius: 0, shadowColor: .lightGray, borderColor: .clear, borderWidth: 0.0)
        
        switch userType {
        case .user:
            let v1 = ChatListVC()
            let v2 = FavouriteVC()
            let v3 = HomeVC()
            let v4 = NotificationVC()
            let v5 = AccountVC()
            
            v1.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "  Chat", image: UIImage(named: "chat"), selectedImage: UIImage(named: "chatSelected"))
            v2.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "  Favourites", image:UIImage(named: "fav"), selectedImage: UIImage(named: "favSelected"))
                let image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysOriginal)
            v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: nil, image: image, selectedImage: image)
            v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "  Notifications", image: UIImage(named: "nt"), selectedImage: UIImage(named: "ntSelected"))
            let img = UIImage(named: "pff")?.withRenderingMode(.alwaysOriginal)
            v5.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "  Account", image: img, selectedImage: img)
//            v5.type = "1"
            v5.userType = self.userType
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
            self.selectedIndex = 2
        case .business:
            let v1 = EventVC()
            let v2 = BusinessFavouriteVC()
            let v3 = BusinessHomeVC()
            let v4 = BusinessNotificationVC()
            let v5 = AccountVC()
            
            v1.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Event", image: UIImage(named: "eventTab"), selectedImage: UIImage(named: "t"))
            v2.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Favourites", image:UIImage(named: "fav"), selectedImage: UIImage(named: "favSelected"))
                let image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysOriginal)
            v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: nil, image: image, selectedImage: image)
            v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Notifications", image: UIImage(named: "nt"), selectedImage: UIImage(named: "ntSelected"))
            let img = UIImage(named: "pff")?.withRenderingMode(.alwaysOriginal)
            v5.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Account", image: img, selectedImage: img)
//            v5.type = "2"
            v5.userType = self.userType
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
            self.selectedIndex = 2

        case .serviceProvider:
            let v1 = ServiceEventVC()
            let v2 = ChatListVC()
            let v3 = ServiceArtistProfileVC()
            let v4 = ServiceShopVC()
            let v5 = AccountVC()
            
            v1.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Event", image: UIImage(named: "eventTab"), selectedImage: UIImage(named: "t"))
            v2.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Chat", image:UIImage(named: "chat"), selectedImage: UIImage(named: "chatSelected"))
                let image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysOriginal)
            v3.tabBarItem = ESTabBarItem(ExampleIrregularityContentView(), title: nil, image: image, selectedImage: image)
            v4.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Shops", image: UIImage(named: "shop"), selectedImage: UIImage(named: "shop"))
            let img = UIImage(named: "pff")?.withRenderingMode(.alwaysOriginal)
            v5.tabBarItem = ESTabBarItem(ExampleIrregularityBasicContentView(), title: "Account", image: img, selectedImage: img)
//            v5.type = "3"
            v5.userType = self.userType
            self.viewControllers = [v1, v2, v3, v4, v5].map({NavigationController(rootViewController: $0)})
            self.selectedIndex = 2

        }
        
        self.tabBar.items?.enumerated().forEach({ index, item in
            item.tag = index
        })
        
    }
    
    func addRedDotAtTabBarItemIndex(index: Int) {
        print("tag *** \(index)")
        for subview in self.tabBar.subviews {
            
            if subview.tag == 1314 {
                subview.removeFromSuperview()
                break
            }
            
        }
        guard index != 2 else {return}
                
        
        let RedDotRadius: CGFloat = 4
        let RedDotDiameter = RedDotRadius * 2

        let TabBarItemCount = CGFloat(self.tabBar.items!.count)
        

        let bottomSafeArea = self.view.safeAreaInsets.bottom
        
        let TopMargin:CGFloat = self.tabBar.frame.height-bottomSafeArea-15

        let itemWidth = self.tabBar.frame.width/CGFloat(TabBarItemCount)
        
        
        let  xOffset = ((CGFloat(index + 1) * itemWidth) - (itemWidth/2))-5

        let frame = CGRect(x: xOffset, y: TopMargin, width: RedDotDiameter, height: RedDotDiameter)
        
        let redDot = UIView(frame: frame)
        print("frame *** \(frame) *** \(bottomSafeArea)")
        redDot.tag = 1314
        redDot.backgroundColor = UIColor.red
        redDot.layer.cornerRadius = RedDotRadius
        self.tabBar.addSubview(redDot)
    }

}


extension TabBarVC:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let size = CGSize(width: tabBarController.tabBar.frame.width / (5),
//                          height: tabBarController.tabBar.frame.height)
//
//        let dotImage = UIImage().createSelectionIndicator(color: .blue, size: size, lineHeight: 7)
//
//        tabBarController.tabBar.selectionIndicatorImage = dotImage
        
        
        
        return true
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
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()

        let innerRect = CGRect(x: (size.width/2) - lineHeight/2,
                               y: size.height - lineHeight - 2,
                               width: lineHeight,
                               height: lineHeight)

        let path = UIBezierPath(roundedRect: innerRect, cornerRadius: lineHeight/2)
        path.fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
