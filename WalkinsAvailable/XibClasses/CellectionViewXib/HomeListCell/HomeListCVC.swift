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
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var categoryData: CategoryList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    //MARK: Methods
    func configureUI() {
        self.mainView.addCornerRadius(view: self.mainView, cornerRadius: 10.0)
//        theImageView.image = theImageView.image?.withRenderingMode(.alwaysTemplate)
        imageBgView.addCornerRadius(view: imageBgView, cornerRadius: imageBgView.bounds.height / 2)
        logoImageView.tintColor = UIColor.red
    }
    
    func setUI(categoryData: CategoryList?) {
        self.categoryData = categoryData
        self.titleLabel.text = self.categoryData?.title
        self.mainView.backgroundColor = UIColor().colorWithHexString(hexString: self.categoryData?.bgColor ?? "")
        self.imageBgView.backgroundColor = UIColor().colorWithHexString(hexString: self.categoryData?.imageBgcolor ?? "")
        self.titleLabel.textColor = UIColor().colorWithHexString(hexString: self.categoryData?.textColor ?? "")
        self.logoImageView.setImage(url: self.categoryData?.image, placeHolder: UIImage(named: "placeHolder"))
    }
    
    
}
