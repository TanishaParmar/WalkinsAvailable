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
    
    func headerView(){
        collectionArtistListView.delegate = self
        collectionArtistListView.dataSource = self
        self.userImgView.layer.cornerRadius = 4
        self.userImgView.clipsToBounds = true
        let nib = UINib(nibName: "BusinessArtistListCell", bundle: nil)
        self.collectionArtistListView.register(nib, forCellWithReuseIdentifier: "BusinessArtistListCell")
    }

}
extension BusinessHomeHeaderView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = (collectionArtistListView.frame.size.width / 5) - 2
      return CGSize(width: collectionViewSize, height: collectionViewSize + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessArtistListCell", for: indexPath) as! BusinessArtistListCell
        if indexPath.row == 0{
            cell.imageView.image = UIImage(named: "add-1")
            cell.nameLbl.isHidden = false
            cell.nameHeightConstraionts.constant = 15
            cell.imageSuperView.layer.borderColor = UIColor.clear.cgColor
            cell.imageSuperView.layer.borderWidth = 0
        }else{
            cell.nameLbl.isHidden = true
            if indexPath.row % 2 == 0 {
                cell.imageSuperView.layer.borderColor = UIColor.green.cgColor
                cell.imageSuperView.layer.borderWidth = 1
            }else{
                cell.imageSuperView.layer.borderColor = UIColor.red.cgColor
                cell.imageSuperView.layer.borderWidth = 1
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            }else{
                print("its work, when i will set the command to navigate to another controller")
            }
        }
    }
