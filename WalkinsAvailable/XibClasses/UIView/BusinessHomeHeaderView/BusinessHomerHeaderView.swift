//
//  BusinessHomerHeaderView.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/8/22.
//

import UIKit

class BusinessHomerHeaderView: UIView {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
    override func awakeFromNib() {
        setUI()
    }
    
    //MARK: - Methods
    func setUI() {
        let data = UserDefaultsCustom.getBusinessData()
        self.businessName.text = data?.businessName
        self.addressLabel.text = data?.businessAddress
        let placeHolder = UIImage(named: "placeHolder")
        self.profileImageView.setImage(url: data?.image, placeHolder: placeHolder)
        self.profileImageView.addCornerRadius(view: self.profileImageView, cornerRadius: 4.0)
    }
    
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let businessEditVC = BusinessEditProfile()
        businessEditVC.data = UserDefaultsCustom.getBusinessData()
        if let topVC = UIApplication.getTopViewController() {
            topVC.navigationController?.pushViewController(businessEditVC, animated: true)
        }
    }
    
}
