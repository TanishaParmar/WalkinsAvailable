//
//  BusinessFavouriteList.swift
//  WalkinsAvailable
//
//  Created by apple on 03/05/22.
//

import UIKit

class BusinessFavouriteList: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCell.layer.cornerRadius = 4
        imgCell.clipsToBounds = true
        authorLbl.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
