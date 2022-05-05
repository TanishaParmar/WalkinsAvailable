//
//  ShopsListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ShopsListCell: UITableViewCell {

    @IBOutlet weak var userProfileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImgView.layer.cornerRadius = 4
        userProfileImgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
