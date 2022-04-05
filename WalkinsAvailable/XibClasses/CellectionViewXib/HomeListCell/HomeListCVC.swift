//
//  HomeListCVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//

import UIKit

class HomeListCVC: UICollectionViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    //MARK: Methods
    func configureUI() {
        self.mainView.addCornerRadius(view: self.mainView, cornerRadius: 10.0)
//        theImageView.image = theImageView.image?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = UIColor.red

    }
}
