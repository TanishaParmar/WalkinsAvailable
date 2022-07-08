//
//  BusinessArtistTotalListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 11/05/22.
//

import UIKit

class BusinessArtistTotalListCell: UITableViewCell {
    
    @IBOutlet weak var imgSuperView: UIView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistAvailabilitySwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        imgSuperView.addCornerBorderAndShadow(view: imgSuperView, cornerRadius: imgSuperView.bounds.height / 2, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        artistImageView.addCornerRadius(view: artistImageView, cornerRadius: artistImageView.bounds.height / 2)
    }
    
    
}
