//
//  FavouriteListTVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//

import UIKit

class FavouriteListTVC: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
