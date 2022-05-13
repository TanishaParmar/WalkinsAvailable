//
//  AccountVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class AccountVC: UIViewController {
    
    //    var type:String = ""
    
    //MARK: Outlets
    @IBOutlet weak var accounttableView: UITableView!
    @IBOutlet weak var accountProfileImgView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var userProfielbl: UILabel!
    
    //MARK: Properties
    
//    var listArr: [(String, String)] = [("Switch account as Business","pf1"),("Switch account as Service Provider","pf2"),("Set Availability","pf9"),("Request invite from shops","shop8"),("About us","pf3"),("Contact us","pf4"),("Complaints","pf5"),("Change Password","pf6"),("Logout","pf7")]
    var userListArr: [(Account_Type, String)] = [(.switchAccountAsBussiness,"pf1"),(.switchAccountAsServiceProvider,"pf2"),(.setAvailability,"pf9"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.complaints,"pf5"),(.changePassword,"pf6"),(.logout,"pf7")]
    var businessListArr: [(Account_Type, String)] = [(.switchAccountAsUser,"profileUser"),(.switchAccountAsServiceProvider,"pf2"),(.setAvailability,"pf9"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.complaints,"pf5"),(.changePassword,"pf6"),(.logout,"pf7")]
    var serviceProviderArr: [(Account_Type, String)] = [(.switchAccountAsUser,"profileUser"),(.switchAccountAsBussiness,"pf1"),(.setAvailability,"pf9"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.changePassword,"pf6"),(.logout,"pf7")]
    
    
    var userType : USER_TYPE = .business
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    //MARK: Methods
    func configureUI() {
        accounttableView.dataSource = self
        accounttableView.delegate = self
        self.accountProfileImgView.layer.cornerRadius = 4
        self.accountProfileImgView.clipsToBounds = true
        let nib = UINib(nibName: "AccountListTVC", bundle: nil)
        accounttableView.register(nib, forCellReuseIdentifier: "AccountListTVC")
        switch userType {
        case .user:
            self.userProfielbl.text = "User Profile"
            break
        case .business:
            self.userProfielbl.text = "Business Profile"
            break
        case .serviceProvider:
            self.userProfielbl.text = "Artist Profile"
            break
        default:
        print("Its Type")
    }
    }
       
    
    //MARK: Actions
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        switch userType {
        case .user:
            let viewcontroller = EditProfileVC()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
            break
        case .business:
            let viewcontroller = BusinessEditProfile()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
            break
        case .serviceProvider:
            let viewcontroller = ServiceProviderEditProfile()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
            break
        default :
            print("its work")
        }
        
    }
}

extension AccountVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listArr.count
        switch userType {
        case .user:
            return userListArr.count
        case .business:
            return businessListArr.count
        case .serviceProvider:
            return serviceProviderArr.count
        default:
            2
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListTVC", for: indexPath) as! AccountListTVC
//        cell.titleLabel.text = listArr[indexPath.row].0
        if indexPath.row > 1 {
            cell.switchIcon.isHidden = true
        }
        
        switch userType{
        case .user:
            cell.titleLabel.text = userListArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: userListArr[indexPath.row].1)
        case .business:
            cell.titleLabel.text = businessListArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: businessListArr[indexPath.row].1)
            if indexPath.row == 1{
                cell.switchIcon.onTintColor = UIColor.blue
            }
        case .serviceProvider:
            cell.titleLabel.text = serviceProviderArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: serviceProviderArr[indexPath.row].1)
            if indexPath.row == 1{
                cell.switchIcon.onTintColor = UIColor.blue
            }
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch userType {
        case .user:
            if indexPath.row == 2{
                return 0
            }else if indexPath.row == 3{
                return 0
            }else{
                return 60
            }
            break
        case .business:
            if indexPath.row == 2{
                return 60
            }else if indexPath.row == 3{
                return 0
            }else{
                return 60
            }
            break
        case .serviceProvider:
            if indexPath.row == 6{
                return 60
            }else if indexPath.row == 3{
                return 60
            }else{
                return 60
            }
            break
        default:
            break
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch userType {
        case .user:
            if indexPath.row == 0{
                let viewcontroller = SignUpBusinessProfile()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }else if indexPath.row == 1 {
                let controller = SignUpServiceProvider()
                self.push(viewController: controller)
            }else  if indexPath.row == 2 {
                let controller = SetAvailbilityVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 4{
                let controller = AboutUsVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 5 {
                let viewcontroller = ContactUsVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 6 {
                let viewcontroller = ComplaintsVC()
                viewcontroller.userType = self.userType
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 7 {
                let viewcontroller = ChangePasswordVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 8{
                self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                    let controller = UINavigationController(rootViewController: LoginVC())
                   
                    Singleton.window?.rootViewController = controller
                    Singleton.window?.makeKeyAndVisible()
                },{
                    cancel in
                    self.dismiss(animated: false, completion: nil)
                }])
            }
            break
        case .business:
            if indexPath.row == 0{
                let viewcontroller = SignUpAsUserVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }else if indexPath.row == 1 {
                let controller = SignUpServiceProvider()
                self.push(viewController: controller)
            }else  if indexPath.row == 2 {
                let controller = SetAvailbilityVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 4{
                let controller = AboutUsVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 5 {
                let viewcontroller = ContactUsVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 6 {
                let viewcontroller = ComplaintsVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 7 {
                let viewcontroller = ChangePasswordVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }
            else if indexPath.row == 8{
                self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                    let controller = UINavigationController(rootViewController: LoginVC())
                   
                    Singleton.window?.rootViewController = controller
                    Singleton.window?.makeKeyAndVisible()

                },{
                    cancel in
                    self.dismiss(animated: false, completion: nil)
                }])
            }
            break
        case .serviceProvider:
            if indexPath.row == 0{
                let viewcontroller = SignUpAsUserVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }else if indexPath.row == 1 {
                let controller = SignUpBusinessProfile()
                self.push(viewController: controller)
            }else  if indexPath.row == 2 {
                let controller = SetAvailbilityVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 3{
                let controller = InviteFromShopVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 4{
                let controller = AboutUsVC()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else if indexPath.row == 5 {
                let viewcontroller = ContactUsVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 6 {
                let viewcontroller = ChangePasswordVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 7{
                self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                    let controller = UINavigationController(rootViewController: LoginVC())
                   
                    Singleton.window?.rootViewController = controller
                    Singleton.window?.makeKeyAndVisible()
                },{
                    cancel in
                    self.dismiss(animated: false, completion: nil)
                }])
            }
            break
        default:
            break
        }
        
    }
    
    
    
    
}


extension UIViewController {
    func popActionAlert(title:String,message:String,actionTitle:[String],actionStyle:[UIAlertAction.Style],action:[(UIAlertAction) -> Void]){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        for (index,title) in actionTitle.enumerated(){
            let action = UIAlertAction.init(title: title, style: actionStyle[index], handler: action[index])
            alert.addAction(action)
            alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        print(vc)
      popToViewController(vc, animated: animated)
    }
  }
}
