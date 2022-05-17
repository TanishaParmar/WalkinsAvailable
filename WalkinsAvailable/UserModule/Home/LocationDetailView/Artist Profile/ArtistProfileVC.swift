//
//  ArtistProfileVC.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//

import UIKit

class ArtistProfileVC: UIViewController {

    var imgArr:[String] = ["img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4","img1","img2","img3","img4"]
    
//    MARK: OUTLETS
    @IBOutlet weak var artistImgVw: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var artistImgCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistImgCollectionView.delegate = self
        self.artistImgCollectionView.dataSource = self
        artistImgVw.layer.cornerRadius = 4
        artistImgVw.clipsToBounds = true
        let nib = UINib(nibName: "ArtistListImgCell", bundle: nil)
        self.artistImgCollectionView.register(nib, forCellWithReuseIdentifier: "ArtistListImgCell")
//        self.artistImgVw.layer.cornerRadius = artistImgVw.frame.height/2
//        self.artistImgVw.clipsToBounds = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chatBtn(_ sender: UIButton) {
        let controller = SingleChatController()
        self.push(viewController: controller)
    }
    
    @IBAction func favBtn(_ sender: UIButton) {
        
    }
}
extension ArtistProfileVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let padding: CGFloat =  artistImgCollectionView.frame.size.width
      let collectionViewSize = artistImgCollectionView.frame.size.width - 2
      return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListImgCell", for: indexPath) as! ArtistListImgCell
        cell.imgCell.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
    
}
