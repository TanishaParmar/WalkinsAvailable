//
//  BusinessArtistListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessArtistListCell: UICollectionViewCell {

    @IBOutlet weak var imageSuperView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameHeightConstraionts: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.addCornerRadius(view: self.imageView, cornerRadius: self.imageSuperView.frame.height/2)
        self.imageSuperView.addCornerBorderAndShadow(view: self.imageSuperView, cornerRadius: self.imageSuperView.frame.height/2, shadowColor: .clear, borderColor: .green, borderWidth: 1.5)
    }

}
