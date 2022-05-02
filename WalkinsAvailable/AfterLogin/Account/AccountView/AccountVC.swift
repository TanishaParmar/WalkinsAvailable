//
//  AccountVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class AccountVC: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editProfileButton: UIButton!
    
    //MARK: Properties
    var listArr: [(String, String)] = [("Switch account as Business",""),("Switch account as Service Provider",""),("About us",""),("Contact us",""),("Complaints",""),("Change Password",""),("Logout","")]
    var imgArr: [String] = ["pf1","pf2","pf3","pf4","pf5","pf6","pf7"]
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //MARK: Methods
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "AccountListTVC", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AccountListTVC")
    }
    
    
    //MARK: Actions
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let viewcontroller = EditProfileVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}

extension AccountVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListTVC", for: indexPath) as! AccountListTVC
        cell.titleLabel.text = listArr[indexPath.row].0
        if indexPath.row > 1 {
            cell.switchIcon.isHidden = true
        }
        cell.iconImageView.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let viewcontroller = SignUpBusinessProfile()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        else if indexPath.row == 1 {
            let controller = SignUpServiceProvider()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 2{
            let controller = AboutUsVC()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 3 {
            let viewcontroller = ContactUsVC()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        } else if indexPath.row == 4 {
            let viewcontroller = ComplaintsVC()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        } else if indexPath.row == 5 {
            let viewcontroller = ChangePasswordVC()
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    
    
}


