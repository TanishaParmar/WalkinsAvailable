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
    
    var artistId = String()
    var artistDetail: ArtistDetail = ArtistDetail()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistImgCollectionView.delegate = self
        self.artistImgCollectionView.dataSource = self
        artistImgVw.layer.cornerRadius = 4
        artistImgVw.clipsToBounds = true
        let nib = UINib(nibName: "ArtistListImgCell", bundle: nil)
        self.artistImgCollectionView.register(nib, forCellWithReuseIdentifier: "ArtistListImgCell")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitArtistDetailApi()
    }
    
    
    
    func getImages() -> [String] {
        if self.artistDetail.artistImages?.count ?? 0 > 0 {
            return (self.artistDetail.artistImages?.map({$0.image ?? ""}))!
        }
        return [String]()
    }
    
    
    func setUIElements() {
        print("api response...")
        self.artistNameLbl.text = self.artistDetail.ownerName
        let placeHolder = UIImage(named: "placeHolder")
        self.artistImgVw.setImage(url: self.artistDetail.image, placeHolder: placeHolder)
        artistImgCollectionView.reloadData()
    }
    
    
    //MARK: hit Artist Detail Api
    func hitArtistDetailApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.viewArtistDetail, params: ["artistId": self.artistId ?? ""]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: ArtistDetailsModel.self) {
                    if let data = response.data {
                        self.artistDetail = data
                        self.setUIElements()
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
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
//extension ArtistProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imgArr.count
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
//    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let padding: CGFloat =  artistImgCollectionView.frame.size.width
//      let collectionViewSize = artistImgCollectionView.frame.size.width - 2
//      return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListImgCell", for: indexPath) as! ArtistListImgCell
//        cell.imgCell.image = UIImage(named: imgArr[indexPath.row])
//        return cell
//    }
//
//
//}



extension ArtistProfileVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistDetail.artistImages?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListImgCell", for: indexPath) as! ArtistListImgCell
        cell.imgCell.setImageView(urls: getImages(), placeholder: UIImage(), item: indexPath.item, controller: self)
//        cell.setUI(artistImages: self.artistDetail.artistImages?[indexPath.row], delegate: nil)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let collectionViewSize = (collectionView.frame.size.width - 6) / 3
      return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

}



extension ArtistProfileVC: DeleteArtistPopUpVCDelegate {
    func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
