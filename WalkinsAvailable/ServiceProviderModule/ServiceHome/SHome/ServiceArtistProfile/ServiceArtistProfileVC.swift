//
//  BusinessArtistProfileVC.swift
//  WalkinsAvailable
//
//  Created by apple on 04/05/22.
//

import UIKit
import Photos

class ServiceArtistProfileVC: UIViewController {

//    var imgArr:[String] = ["1ar","2ar","1ar","3ar","4ar","5ar","ghar","2ar","ghar","2ar","uu","uyyu","wqw","wwe","yyt","3ar","4ar","5ar","ghar","2ar"]
    
    @IBOutlet weak var collectionImgView: UICollectionView!
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var artistStatusButton: UISwitch!
    @IBOutlet weak var artistDescriptionLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var addArtistBtn: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var setAvailabilityBtn: UIButton!
    
    var imgArr: [ArtistImages] = [ArtistImages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistImgView.layer.cornerRadius = 4
        artistImgView.clipsToBounds = true
        collectionImgView.delegate = self
        collectionImgView.dataSource = self
        let nib = UINib(nibName: "ArtistListImgCell", bundle: nil)
        self.collectionImgView.register(nib, forCellWithReuseIdentifier: "ArtistListImgCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        hitArtistProfileHomeApi()
    }
    
    
    
    //MARK: Hit Edit Profile API
    func hitArtistProfileHomeApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.artistHomeProfile, params: [:]) { succeeded, response, data in
            //            debugPrint("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: ArtistDetailsModel.self) {
                    self.artistNameLbl.text = response.data?.ownerName
                    let placeHolder = UIImage(named: "placeHolder")
                    self.artistImgView.setImage(url: response.data?.image, placeHolder: placeHolder)
                    if let data = response.data?.artistImages {
                        self.imgArr = data
                        self.collectionImgView.reloadData()
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }


    
//    MARK: BUTTON ACTIONS
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let artistEditVC = ServiceProviderEditProfile()
        artistEditVC.data = UserDefaultsCustom.getArtistData()
        self.navigationController?.pushViewController(artistEditVC, animated: true)

    }
    
    
    @IBAction func notificationBtn(_ sender: UIButton) {
     let controller = ServiceNotificationVC()
        self.push(viewController: controller)
    }
    
    @IBAction func addArtistBtn(_ sender: UIButton) {
        let controller = ArtistEventInvitedVC()
        self.push(viewController: controller)
    }
    
    @IBAction func addImageBtn(_ sender: UIButton) {
    let controller = GalleryVC()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(controller, animated: true, completion: nil)
//        self.push(viewController: controller)
    }
    
    @IBAction func setAvailabilityBtn(_ sender: UIButton) {
        let controller = SetAvailbilityVC()
        self.push(viewController: controller)
    }
    
    @IBAction func switchBtn(_ sender: UISwitch) {
        
    }
    
}


extension ServiceArtistProfileVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListImgCell", for: indexPath) as! ArtistListImgCell
        cell.setUI(artistImages: imgArr[indexPath.row])
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let collectionViewSize = (collectionImgView.frame.size.width - 6) / 3
      return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

}


extension ServiceArtistProfileVC: GalleryVCDelegate {
    func galleryController(_ gallery: GalleryVC, didselect items: [PHAsset], assetIds: [String]) {
        let images = items.map({PickerData.init(asset: $0)})
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            ActivityIndicator.sharedInstance.showActivityIndicator()
            ApiHandler.uploadImage(apiName: API.Name.addImage, dataArray: images, imageKey: assetIds, params: [:]) { succeeded, response, data in
                ActivityIndicator.sharedInstance.hideActivityIndicator()
                if succeeded {
                    gallery.dismiss(animated: true, completion: nil)
                }
                else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                        gallery.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func galleryControllerOpenCamera(_ gallery: GalleryVC) {
//        <#code#>
    }
    
    
}
