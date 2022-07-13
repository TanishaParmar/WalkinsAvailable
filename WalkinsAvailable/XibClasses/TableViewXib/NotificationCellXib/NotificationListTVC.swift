//
//  NotificationListTVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//


protocol NotificationListTVCDelegate {
    func acceptRequest(serviceProviderNotificationData: ServiceProviderNotificationData?)
    func rejectRequest(serviceProviderNotificationData: ServiceProviderNotificationData?)
}

import UIKit

class NotificationListTVC: UITableViewCell {
    
    
//    MARK: OUTLETS
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var statusView: UIStackView!
    @IBOutlet weak var authorheighConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusheightConstraint: NSLayoutConstraint!
    
    

    var serviceProviderNotificationData: ServiceProviderNotificationData?
    var delegate: NotificationListTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        acceptView.addCornerRadius(view: acceptView, cornerRadius: 4)
        imgCell.addCornerRadius(view: imgCell, cornerRadius: imgCell.bounds.height / 2)
        rejectView.addCornerBorderAndShadow(view: rejectView, cornerRadius: 4, shadowColor: .clear, borderColor: #colorLiteral(red: 0.8832238317, green: 0.6569672823, blue: 0.6966550946, alpha: 1), borderWidth: 1)
    }
    
    func setUIElements(serviceProviderNotificationData: ServiceProviderNotificationData, delegate: NotificationListTVCDelegate?) {
        self.delegate = delegate
        self.serviceProviderNotificationData = serviceProviderNotificationData
        if serviceProviderNotificationData.notificationType == "1" || serviceProviderNotificationData.notificationType == "2" {
            self.statusView.isHidden = false
            self.authorLbl.isHidden = false
            self.statusheightConstraint.constant = 30
            self.authorheighConstraint.constant = 20
        } else {
            self.statusView.isHidden = true
            self.authorLbl.isHidden = true
            self.statusheightConstraint.constant = -10
            self.authorheighConstraint.constant = -10
        }
        self.authorLbl.text = self.serviceProviderNotificationData?.title
        self.descriptionLbl.text = self.serviceProviderNotificationData?.description
//        self.dateLbl.text = self.serviceProviderNotificationData?.
        let placeHolder = UIImage(named: "w")
        self.imgCell.setImage(url: self.serviceProviderNotificationData?.image, placeHolder: placeHolder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func acceptButtonAction(_ sender: Any) {
        self.delegate?.acceptRequest(serviceProviderNotificationData: self.serviceProviderNotificationData)
    }
    
    @IBAction func rejectButtonAction(_ sender: Any) {
        self.delegate?.rejectRequest(serviceProviderNotificationData: self.serviceProviderNotificationData)
    }
    
    
    
}
