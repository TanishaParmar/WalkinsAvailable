//
//  ComplaintsListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 26/04/22.
//

import UIKit

class ComplaintsListCell: UITableViewCell {

    @IBOutlet weak var userProfileView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var decriptionLbl: UILabel!
    
    var businessComplaintData: BusinessComplaintData?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userProfileView.addCornerRadius(view: self.userProfileView, cornerRadius: userProfileView.frame.height / 2)
        self.statusBtn.addCornerRadius(view: self.statusBtn, cornerRadius: 8)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUIForUser(businessComplaintData: BusinessComplaintData?) {
        self.businessComplaintData = businessComplaintData
        self.statusBtn.setTitle(self.businessComplaintData?.status == "0" ? "Pending" : "Resolve", for: .normal)
        self.decriptionLbl.text = self.businessComplaintData?.compDescription
        if let businessDetail = self.businessComplaintData?.businessDetails {
            self.nameLbl.text = businessDetail.businessName
            self.userProfileView.setImage(url: businessDetail.image, placeHolder: UIImage(named: "placeHolder"))
        }
    }
    
    func setUIForBusiness(businessComplaintData: BusinessComplaintData?) {
        self.businessComplaintData = businessComplaintData
        self.statusBtn.setTitle(self.businessComplaintData?.status == "0" ? "Pending" : "Resolve", for: .normal)
        self.decriptionLbl.text = self.businessComplaintData?.compDescription
        if let userDetail = self.businessComplaintData?.userDetails {
            self.nameLbl.text = userDetail.userName
            self.userProfileView.setImage(url: userDetail.image, placeHolder: UIImage(named: "placeHolder"))
        }
    }
    
}
