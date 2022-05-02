//
//  ComplaintDetailCell.swift
//  WalkinsAvailable
//
//  Created by apple on 26/04/22.
//

import UIKit

class ComplaintDetailCell: UITableViewCell {
    
//MARK: OUTLETS
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var shopNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var complaintsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.complaintsView.layer.cornerRadius = 6
        self.complaintsView.layer.borderColor = UIColor.gray.cgColor
        self.complaintsView.layer.borderWidth = 1
        self.statusLbl.layer.cornerRadius = 8
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
