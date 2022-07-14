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
    
    var associatedData: SearchBusinessData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImgView.addCornerRadius(view: userProfileImgView, cornerRadius: 4.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUI(associatedData: SearchBusinessData?) {
        self.associatedData = associatedData
        self.nameLbl.text = self.associatedData?.businessName
        self.descriptionLbl.text = self.associatedData?.businessDescription
        let placeHolder = UIImage(named: "placeHolder")
        self.userProfileImgView.setImage(url: self.associatedData?.image, placeHolder: placeHolder)
    }
    
}
