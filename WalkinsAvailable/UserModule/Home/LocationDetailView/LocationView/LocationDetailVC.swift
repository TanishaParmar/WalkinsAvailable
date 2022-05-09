//
//  LocationDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import UIKit

class LocationDetailVC: UIViewController {
    
    var imgArr:[String] = ["img1","img2","img3","img4","img5"]
    
//    MARK: OUTLETS
    @IBOutlet weak var favImgView: UIImageView!
    @IBOutlet weak var commentView: UIImageView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var locationImgView: UIImageView!
    @IBOutlet weak var locationAddressLbl: UILabel!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var locationDescriptionLbl: UILabel!
    @IBOutlet weak var locationStatusLbl: UILabel!
    @IBOutlet weak var waitingTimeLbl: UILabel!
    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var locationDetailView: UIView!
    var parentVC:MapController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiUpdate()
        self.artistCollectionView.delegate = self
        self.artistCollectionView.dataSource = self
        let nib = UINib(nibName: "ArtistListCell", bundle: nil)
        artistCollectionView.register(nib, forCellWithReuseIdentifier: "ArtistListCell")
    }

    @IBAction func commentBtn(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let controller = ComplaintViewVC()
            self.parentVC?.present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func backBtn(_ sender: UIButton) {

    }
    
    func uiUpdate(){
        self.locationDetailView.clipsToBounds = true
        self.locationDetailView.layer.cornerRadius = 20
        self.locationDetailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.locationStatusLbl.layer.borderColor =  UIColor.gray.cgColor
        self.locationStatusLbl.layer.borderWidth = 1
        self.locationStatusLbl.layer.cornerRadius = 4
    }
}

extension LocationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            let controller = ArtistProfileVC()
            self.parentVC?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListCell", for: indexPath) as! ArtistListCell
        cell.artistImgView.image = UIImage(named: imgArr[indexPath.row])
        if indexPath.row == 0{
            cell.superImageView.layer.borderColor = UIColor.green.cgColor
            cell.superImageView.layer.borderWidth = 1
            cell.artistImgView.layer.borderColor = UIColor.green.cgColor
            cell.artistImgView.layer.borderWidth = 1.5
        }else{
            cell.superImageView.layer.borderColor = UIColor.clear.cgColor
            cell.superImageView.layer.borderWidth = 1
            cell.artistImgView.layer.borderColor = UIColor.red.cgColor
            cell.artistImgView.layer.borderWidth = 1
        }
        return cell
    }
   
}
