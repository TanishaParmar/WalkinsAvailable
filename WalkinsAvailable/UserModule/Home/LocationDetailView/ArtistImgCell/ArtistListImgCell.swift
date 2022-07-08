//
//  ArtistListImgCell.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//

import UIKit
import Kingfisher

class ArtistListImgCell: UICollectionViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var superViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(artistImages: ArtistImages) {
        let placeHolder = UIImage(named: "placeHolder")
        self.imgCell.setImage(url: artistImages.image, placeHolder: placeHolder)
    }

}
