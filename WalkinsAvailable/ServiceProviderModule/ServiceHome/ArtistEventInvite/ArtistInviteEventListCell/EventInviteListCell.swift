//
//  EventInviteListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class EventInviteListCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var namerLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rejectBtn.layer.borderColor = #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1)
        rejectBtn.layer.borderWidth = 1
        rejectBtn.layer.cornerRadius = 4
        acceptBtn.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
