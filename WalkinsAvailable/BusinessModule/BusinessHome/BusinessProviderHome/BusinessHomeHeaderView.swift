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
    
    
    class var view: BusinessHomeHeaderView {
        return UINib(nibName: "BusinessHomeHeaderView", bundle: nil).instantiate(withOwner: nil).first as! BusinessHomeHeaderView
    }
    
    
//    self.userImgView.layer.cornerRadius = 4
    
    

}
