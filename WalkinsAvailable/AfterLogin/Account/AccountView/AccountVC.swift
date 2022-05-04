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
    
    //MARK: Methods
    func configureUI() {
        accounttableView.dataSource = self
        accounttableView.delegate = self
        self.accountProfileImgView.layer.cornerRadius = 4
        let nib = UINib(nibName: "AccountListTVC", bundle: nil)
        accounttableView.register(nib, forCellReuseIdentifier: "AccountListTVC")
    }
    
    //MARK: Actions
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let viewcontroller = EditProfileVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
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
                return 40
            }
            break
        case .business:
            if indexPath.row == 2{
                return 40
            }else if indexPath.row == 3{
                return 0
            }else{
                return 40
            }
            break
        case .serviceProvider:
            if indexPath.row == 6{
                return 0
            }else if indexPath.row == 3{
                return 40
            }else{
                return 40
            }
            break
        default:
            break
        }
        return 40
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
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            } else if indexPath.row == 7 {
                let viewcontroller = ChangePasswordVC()
                self.navigationController?.pushViewController(viewcontroller, animated: true)
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
            break
        default:
            break
        }
        
    }
    
    
    
    
}


