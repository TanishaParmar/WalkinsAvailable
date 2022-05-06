//
//  BusinessComplaintdetailCell.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessComplaintdetailCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var complaintsView: UIView!
    @IBOutlet weak var replydescriptionView: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var replyUIview: UIView!
    @IBOutlet weak var btnUiview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.complaintsView.layer.borderWidth = 1
        self.complaintsView.layer.borderColor = UIColor.gray.cgColor
        self.complaintsView.layer.cornerRadius = 4
        self.complaintsView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
