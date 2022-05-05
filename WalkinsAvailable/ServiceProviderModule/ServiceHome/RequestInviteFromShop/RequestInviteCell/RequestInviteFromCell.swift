//
//  RequestInviteFromCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class RequestInviteFromCell: UITableViewCell {

    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        requestBtn.layer.cornerRadius = 4
        requestBtn.clipsToBounds = true
        imgCell.layer.cornerRadius = imgCell.frame.size.width / 2
        imgCell.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
