//
//  AccountVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit
import Kingfisher

class AccountVC: UIViewController {
    
    //    var type:String = ""
    
    //MARK: Outlets
    @IBOutlet weak var accounttableView: UITableView!
    @IBOutlet weak var accountProfileImgView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var userProfielbl: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    //MARK: Properties
    
//    var listArr: [(String, String)] = [("Switch account as Business","pf1"),("Switch account as Service Provider","pf2"),("Set Availability","pf9"),("Request invite from shops","shop8"),("About us","pf3"),("Contact us","pf4"),("Complaints","pf5"),("Change Password","pf6"),("Logout","pf7")]
    var userListArr: [(Account_Type, String)] = [(.switchAccountAsBussiness,"pf1"),(.switchAccountAsServiceProvider,"pf2"),(.setAvailability,"pf9"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.complaints,"pf5"),(.changePassword,"pf6"),(.logout,"pf7")]
    var businessListArr: [(Account_Type, String)] = [(.switchAccountAsUser,"profileUser"),(.switchAccountAsServiceProvider,"pf2"),(.pastEvents,"pf9"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.complaints,"pf5"),(.changePassword,"pf6"),(.logout,"pf7")]
    var serviceProviderArr: [(Account_Type, String)] = [(.switchAccountAsUser,"profileUser"),(.switchAccountAsBussiness,"pf1"),(.requestInvitesForShops,"shop8"),(.aboutUs,"pf3"),(.contactUs,"pf4"),(.changePassword,"pf6"),(.logout,"pf7")]
    
    
    var userType : USER_TYPE = .user
//    var data: UserData?
    var data: UserModel?
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getUserData()
    }
    
    
    //MARK: Methods
    func configureUI() {
        accounttableView.dataSource = self
        accounttableView.delegate = self
        self.accountProfileImgView.layer.cornerRadius = 4
        self.accountProfileImgView.clipsToBounds = true
        let nib = UINib(nibName: "AccountListTVC", bundle: nil)
        accounttableView.register(nib, forCellReuseIdentifier: "AccountListTVC")
        self.accounttableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 50, right: 0)
        switch userType {
        case .user:
            self.userProfielbl.text = "User Profile"
            break
        case .business:
            self.userProfielbl.text = "Business Profile"
            break
        case .serviceProvider:
            self.userProfielbl.text = "Service Provider Profile"
            break
        default:
            print("Its Type")
        }
    }
    
    func getUserData() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        if let data = UserDefaultsCustom.getUserModel() {
            self.data = data
            switch userType {
            case .user:
                if let userData = UserDefaultsCustom.getUserData() {
                    debugPrint("user data * \(data)")
                    self.userNameLabel.text = userData.userName
                    self.userEmailLabel.text = userData.email
                    let imgUrl = userData.image ?? ""
                    let placeHolder = UIImage(named: "placeHolder")
                    self.accountProfileImgView.setImage(url: imgUrl, placeHolder: placeHolder)
                }
            case .business:
                if let businessData = UserDefaultsCustom.getBusinessData() {
                    debugPrint("user data * \(data)")
                    self.userNameLabel.text = businessData.businessName
                    self.userEmailLabel.text = businessData.email
                    let imgUrl = businessData.image ?? ""
                    let placeHolder = UIImage(named: "placeHolder")
                    self.accountProfileImgView.setImage(url: imgUrl, placeHolder: placeHolder)
                }
            case .serviceProvider:
                if let data = UserDefaultsCustom.getArtistData() {
                    debugPrint("user data * \(data)")
                    self.userNameLabel.text = data.ownerName
                    self.userEmailLabel.text = data.email
                    let imgUrl = data.image ?? ""
                    let placeHolder = UIImage(named: "placeHolder")
                    self.accountProfileImgView.setImage(url: imgUrl, placeHolder: placeHolder)
                }
//            case .none:
//                break
            }
        }
        
//        if let data = UserDefaultsCustom.getUserData() {
//            debugPrint("user data * \(data)")
//            self.data = data
//            self.userNameLabel.text = self.data?.userName
//            self.userEmailLabel.text = self.data?.email
//            let imgUrl = self.data?.image
//            let placeHolder = UIImage(named: "placeHolder")
//            self.accountProfileImgView.setImage(url: imgUrl, placeHolder: placeHolder)
//        }
        ActivityIndicator.sharedInstance.hideActivityIndicator()
    }
    
    
    func generatingBusinessHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        if let businessData = self.data?.businessData {
            params["businessId"] = businessData.businessId
        }
        debugPrint("params data ** \(params)")
        return params
    }

    //MARK: Hit Business Home API
    func hitBusinessHomeApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessHomeDetail, params: generatingBusinessHomeParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: BusinessDataResponseModel.self) {
                        if let data = response.data?.businessDetails {
//                            UserDefaults.standard.set("business", forKey: "loginType")
//                            UserDefaultsCustom.saveUserData(userData: data)
//                            Singleton.setHomeScreenView()
                        }
                        //                    Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                        //                    self.navigationController?.popToRootViewController(animated: true)
                    }
                }
                else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
    }
    
    
    func generatingUserHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        if let businessID = UserDefaultsCustom.getBusinessData()?.businessTypeId {
            params["businessTypeId"] = businessID
        }
        params["search"] = "chamkaur"
        params["userToken"] = UserDefaultsCustom.getUserToken
        debugPrint("params data ** \(params)")
        return params
    }

    //MARK: Hit User Home API
    func hitUserHomeApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessBySearch, params: generatingUserHomeParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
//                    if let response = DataDecoder.decodeData(data, type: UserDataResponseModel.self) {
//                        if let data = response.data?.userDetails {
//                            UserDefaults.standard.set("user", forKey: "loginType")
//                            UserDefaultsCustom.saveUserData(userData: data)
//                            Singleton.setHomeScreenView()
//                        }
//                    }
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
    }
    
    
    func generatingArtistHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        if let artistData = self.data?.artistData {
            params["artistId"] = artistData.artistId
        }
        debugPrint("params data ** \(params)")
        return params
    }

    //MARK: Hit Artist Home API
    func hitArtistHomeApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.artistHomeProfile, params: generatingArtistHomeParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: ArtistDataResponseModel.self) {
                        if let data = response.data?.artistDetails {
                            UserDefaults.standard.set("serviceProvider", forKey: "loginType")
                            UserDefaultsCustom.saveUserData(userData: data)
                            Singleton.setHomeScreenView()
                        }
                    }
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
    }
    
    func saveUserData() {
        switch userType {
        case .user:
            UserDefaultsCustom.saveUserLogin(loginType: "1")
        case .business:
            UserDefaultsCustom.saveUserLogin(loginType: "2")
        case .serviceProvider:
            UserDefaultsCustom.saveUserLogin(loginType: "3")
        }
    }

    
    func generatingLogOutParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        switch userType {
        case .user:
            params["loginRole"] = 1
        case .business:
            params["loginRole"] = 2
        case .serviceProvider:
            params["loginRole"] = 3
//        case .none:
//            break
        }
        
        debugPrint("params data ** \(params)")
        return params
    }
    
    //MARK: Hit Logout API
    func hitLogOutApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.logOut, params: generatingLogOutParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                self.saveUserData()
                if let msg = response["message"] as? String {
//                    Singleton.shared.showErrorMessage(error: msg, isError: .success)
                    Singleton.shared.logoutFromDevice()
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        switch userType {
        case .user:
            let userEditVC = EditProfileVC()
            userEditVC.data = self.data?.userData
            self.navigationController?.pushViewController(userEditVC, animated: true)
            break
        case .business:
            let businessEditVC = BusinessEditProfile()
            businessEditVC.data = self.data?.businessData
            self.navigationController?.pushViewController(businessEditVC, animated: true)
            break
        case .serviceProvider:
            let artistEditVC = ServiceProviderEditProfile()
            artistEditVC.data = self.data?.artistData
            self.navigationController?.pushViewController(artistEditVC, animated: true)
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListTVC", for: indexPath) as! AccountListTVC
//        cell.titleLabel.text = listArr[indexPath.row].0
        cell.switchIcon.isHidden = indexPath.row > 1
        switch userType {
        case .user:
            cell.titleLabel.text = userListArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: userListArr[indexPath.row].1)
            if indexPath.row == 0 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0, green: 0.8551515937, blue: 0.6841568947, alpha: 1)
                let businessData = UserDefaultsCustom.getBusinessData()
                cell.switchIcon.isOn = businessData?.businessId != "0" && (businessData?.businessId?.count ?? 0 > 0)
            } else if indexPath.row == 1 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0.1782743335, green: 0.09970747679, blue: 0.8259038329, alpha: 1)
                let artistData = UserDefaultsCustom.getArtistData()
                cell.switchIcon.isOn = artistData?.artistId != "0" && (artistData?.artistId?.count ?? 0 > 0)
            }
        case .business:
            cell.titleLabel.text = businessListArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: businessListArr[indexPath.row].1)
            if indexPath.row == 0 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0.2428347766, green: 0.9325304627, blue: 0.4965850115, alpha: 1)
                let userData = UserDefaultsCustom.getUserData()
                cell.switchIcon.isOn = (userData?.userName?.count ?? 0 > 0)
            } else if indexPath.row == 1 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0.1782743335, green: 0.09970747679, blue: 0.8259038329, alpha: 1)
                let artistData = UserDefaultsCustom.getArtistData()
                cell.switchIcon.isOn = artistData?.artistId != "0" && (artistData?.artistId?.count ?? 0 > 0)
            }
        case .serviceProvider:
            cell.titleLabel.text = serviceProviderArr[indexPath.row].0.rawValue
            cell.iconImageView.image = UIImage(named: serviceProviderArr[indexPath.row].1)
            if indexPath.row == 0 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0.2428347766, green: 0.9325304627, blue: 0.4965850115, alpha: 1)
                let userData = UserDefaultsCustom.getUserData()
                cell.switchIcon.isOn = (userData?.userName?.count ?? 0 > 0)
            } else if indexPath.row == 1 {
                cell.switchIcon.onTintColor = #colorLiteral(red: 0.1782743335, green: 0.09970747679, blue: 0.8259038329, alpha: 1)
                let businessData = UserDefaultsCustom.getBusinessData()
                cell.switchIcon.isOn = businessData?.businessId != "0" && (businessData?.businessId?.count ?? 0 > 0)
            }
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
//        default:
//            break
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userId = UserDefaultsCustom.getUserData()?.userId {
            switch userType {
            case .user:
                if indexPath.row == 0 {
                    if let businessData = UserDefaultsCustom.getBusinessData(), businessData.businessId != "0"  {
                        //                    print("its work", businessId)
//                        hitBusinessHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "2")
                        Singleton.setHomeScreenView()
                    } else {
                        let viewcontroller = SignUpBusinessProfile()
                        viewcontroller.userId = UserDefaultsCustom.getUserData()?.userId ?? ""
                        viewcontroller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: viewcontroller)
                    }
                } else if indexPath.row == 1 {
                    if let artistData = UserDefaultsCustom.getArtistData(), artistData.artistId != "0"  {
                        //                    print("its work", artistId)
//                        hitArtistHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "3")
                        Singleton.setHomeScreenView()
                    } else {
                        let controller = SignUpServiceVC()
                        controller.userId = UserDefaultsCustom.getUserData()?.userId ?? ""
                        controller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: controller)
                    }
                } else  if indexPath.row == 2 {
                    let controller = SetAvailbilityVC()
                    self.navigationController?.pushViewController(controller, animated: true)
                } else if indexPath.row == 4 {
//                    let controller = AboutUsVC()
//                    self.navigationController?.pushViewController(controller, animated: true)
                    let urlString = API.UrlName.aboutUs
                    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } else if indexPath.row == 5 {
                    let contactVC = ContactUsVC()
                    contactVC.data = self.data
                    self.navigationController?.pushViewController(contactVC, animated: true)
                } else if indexPath.row == 6 {
                    let viewcontroller = ComplaintsVC()
                    viewcontroller.userType = self.userType
                    self.navigationController?.pushViewController(viewcontroller, animated: true)
                } else if indexPath.row == 7 {
                    let viewcontroller = ChangePasswordVC()
                    self.navigationController?.pushViewController(viewcontroller, animated: true)
                } else if indexPath.row == 8 {
                    self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                        self.hitLogOutApi()
                    },{
                        cancel in
                        self.dismiss(animated: false, completion: nil)
                    }])
                }
                break
            case .business:
                if indexPath.row == 0{
                    if let userData = UserDefaultsCustom.getUserData(), (userData.userName?.count ?? 0 > 0)  { // userData.userId != "0"
                        //                    print("its work", userId)
//                        hitUserHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "1")
                        Singleton.setHomeScreenView()
                    } else {
                        let controller = SignUpAsUserVC()
                        controller.userId = UserDefaultsCustom.getUserData()?.userId ?? "" //self.userNameLabel.text ?? ""
                        controller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: controller)
                    }
                }else if indexPath.row == 1 {
                    if let artistData = UserDefaultsCustom.getArtistData(), artistData.artistId != "0"  {
                        //                    print("its work", artistId)
//                        hitArtistHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "3")
                        Singleton.setHomeScreenView()
                    } else {
                        let controller = SignUpServiceVC()
                        controller.userId = UserDefaultsCustom.getUserData()?.userId ?? ""
                        controller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: controller)
                    }
                }else  if indexPath.row == 2 {
                    let controller = ServiceEventVC()
                    controller.isFromSettings = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else if indexPath.row == 4{
//                    let controller = AboutUsVC()
//                    self.navigationController?.pushViewController(controller, animated: true)
                    let urlString = API.UrlName.aboutUs
                    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
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
                }
                else if indexPath.row == 8{
                    self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                        self.hitLogOutApi()
                    },{
                        cancel in
                        self.dismiss(animated: false, completion: nil)
                    }])
                }
                break
            case .serviceProvider:
                if indexPath.row == 0{
                    if let userData = UserDefaultsCustom.getUserData(), (userData.userName?.count ?? 0 > 0) { // userData.userId != "0"
                        //                    print("its work", userId)
//                        hitUserHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "1")
                        Singleton.setHomeScreenView()
                    } else {
                        let controller = SignUpAsUserVC()
                        controller.userId = UserDefaultsCustom.getUserData()?.userId ?? ""  //self.userNameLabel.text ?? ""
                        controller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: controller)
                    }
                }else if indexPath.row == 1 {
                    if let businessData = UserDefaultsCustom.getBusinessData(), businessData.businessId != "0"  {
                        //                    print("its work", businessId)
//                        hitBusinessHomeApi()
                        UserDefaultsCustom.saveUserLogin(loginType: "2")
                        Singleton.setHomeScreenView()
                    } else {
                        let viewcontroller = SignUpBusinessProfile()
                        viewcontroller.userId = UserDefaultsCustom.getUserData()?.userId ?? ""
                        viewcontroller.emailId = self.userEmailLabel.text ?? ""
                        self.push(viewController: viewcontroller)
                    }
                    
                }
                else if indexPath.row == 2{
                    let controller = InviteFromShopVC()
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else if indexPath.row == 3{
//                    let controller = AboutUsVC()
//                    self.navigationController?.pushViewController(controller, animated: true)
                    let urlString = API.UrlName.aboutUs
                    if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                else if indexPath.row == 4 {
                    let viewcontroller = ContactUsVC()
                    self.navigationController?.pushViewController(viewcontroller, animated: true)
                } else if indexPath.row == 5 {
                    let viewcontroller = ChangePasswordVC()
                    self.navigationController?.pushViewController(viewcontroller, animated: true)
                } else if indexPath.row == 6{
                    self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: "Are you sure you want to logout ?", actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                        self.hitLogOutApi()
                        
                        //                    let controller = UINavigationController(rootViewController: LoginVC())
                        //
                        //                    Singleton.window?.rootViewController = controller
                        //                    Singleton.window?.makeKeyAndVisible()
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
