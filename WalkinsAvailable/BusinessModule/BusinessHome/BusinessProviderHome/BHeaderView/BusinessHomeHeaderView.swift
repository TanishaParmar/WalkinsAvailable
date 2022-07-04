//
//  BusinessHomeHeaderView.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class BusinessHomeHeaderView: UIView {

    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var collectionArtistListView: UICollectionView!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    class var view: BusinessHomeHeaderView {
        return UINib(nibName: "BusinessHomeHeaderView", bundle: nil).instantiate(withOwner: nil).first as! BusinessHomeHeaderView
    }
    
    @IBAction func editProfileBtn(_ sender: UIButton) {
        let businessEditVC = BusinessEditProfile()
        businessEditVC.data = UserDefaultsCustom.getBusinessData()
        if let topVC = UIApplication.getTopViewController() {
            topVC.navigationController?.pushViewController(businessEditVC, animated: true)
        }
    }
    
    
    func headerView(){
        self.userImgView.layer.cornerRadius = 4
        self.userImgView.clipsToBounds = true
        let nib = UINib(nibName: "BusinessArtistListCell", bundle: nil)
        self.collectionArtistListView.register(nib, forCellWithReuseIdentifier: "BusinessArtistListCell")
    }

}

