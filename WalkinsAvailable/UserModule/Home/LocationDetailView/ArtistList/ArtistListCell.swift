//
//  ArtistListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

protocol ArtistListCellDelegate {
    
}

import UIKit

class ArtistListCell: UICollectionViewCell {
    
    var artistsList: ArtistData?
    var delegate: ArtistListCellDelegate?

//    MARK: OUTLETS
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var superImageView: UIView!
    @IBOutlet weak var artistNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.superImageView.layer.cornerRadius = superImageView.frame.height/2
//        self.superImageView.clipsToBounds = true
//        self.artistImgView.layer.cornerRadius = artistImgView.frame.height/2
//        self.artistImgView.clipsToBounds = true
        self.superImageView.addCornerRadius(view: self.superImageView, cornerRadius: superImageView.frame.height/2)
        self.artistImgView.addCornerRadius(view: self.artistImgView, cornerRadius: artistImgView.frame.height/2)
    }
    
    func setUI(artistsList: ArtistData?, delegate: ArtistListCellDelegate?) {
        self.artistsList = artistsList
        self.delegate = delegate
        self.artistImgView.setImage(url: self.artistsList?.image, placeHolder: UIImage(named: "placeHolder"))
        self.artistNameLbl.text = self.artistsList?.ownerName
    }

}
