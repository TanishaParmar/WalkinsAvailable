//
//  ArtistListImgCell.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//


protocol ArtistListImgCellDelegate: NSObjectProtocol {
    func deleteImage(imageId: String?)
}

import UIKit
import Kingfisher


class ArtistListImgCell: UICollectionViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var superViewCell: UIView!
    
    var artistImages: ArtistImages?
    var delegate: ArtistListImgCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.deleteButton.addCornerRadius(view: self.deleteButton, cornerRadius: self.deleteButton.bounds.height / 2)
    }
    
    func setUI(artistImages: ArtistImages?, delegate: ArtistListImgCellDelegate?) {
        self.delegate = delegate
        self.artistImages = artistImages
        let placeHolder = UIImage(named: "placeHolder")
        self.imgCell.setImage(url: self.artistImages?.image, placeHolder: placeHolder)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if let topVC = UIApplication.getTopViewController() {
            topVC.popActionAlert(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.deleteImage, actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                self.delegate?.deleteImage(imageId: self.artistImages?.artistImageId)
            },{
                cancel in
                self.delegate?.deleteImage(imageId: "")
            }])
            
        }
    }
    
    
}
