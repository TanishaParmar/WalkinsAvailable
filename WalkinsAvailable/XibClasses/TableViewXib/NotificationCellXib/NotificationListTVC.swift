//
//  NotificationListTVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//

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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        acceptView.layer.cornerRadius = 4
        acceptView.clipsToBounds = true
        rejectView.layer.cornerRadius = 4
        rejectView.layer.borderColor = #colorLiteral(red: 0.8832238317, green: 0.6569672823, blue: 0.6966550946, alpha: 1)
        rejectView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
