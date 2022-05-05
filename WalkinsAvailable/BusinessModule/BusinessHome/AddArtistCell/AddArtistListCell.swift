//
//  AddArtistListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class AddArtistListCell: UITableViewCell {

    @IBOutlet weak var artistImgCell: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
