//
//  ArtistListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import UIKit

class ArtistListCell: UICollectionViewCell {

//    MARK: OUTLETS
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var superImageView: UIView!
    @IBOutlet weak var artistNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.superImageView.layer.cornerRadius = superImageView.frame.height/2
        self.superImageView.clipsToBounds = true
        self.artistImgView.layer.cornerRadius = artistImgView.frame.height/2
        self.artistImgView.clipsToBounds = true
    }

}
