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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
