//
//  ArtistDetailedVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/12/22.
//

import UIKit

class ArtistDetailedVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var removeArtistButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var artistId: String?
    var artistDetail: ArtistDetail = ArtistDetail()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitArtistDetailApi()
    }
    
    func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ArtistListImgCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "ArtistListImgCell")
    }
    
    func setUIElements() {
        print("api response...")
        self.nameLabel.text = self.artistDetail.ownerName
        let placeHolder = UIImage(named: "placeHolder")
        self.profileImageView.setImage(url: self.artistDetail.image, placeHolder: placeHolder)
        collectionView.reloadData()
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
    
    //MARK: hit Remove Artist Api
    func hitRemoveArtistApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        //MARK: Hit Business Home API
        ApiHandler.updateProfile(apiName: API.Name.addArtist, params: ["isRemove": "1", "artistId": self.artistDetail.artistId ?? ""]) { succeeded, response, dataRes in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                
                self.navigationController?.popToRootViewController(animated: true)
//                data?.isJoin = "Requested"
//                sender.setTitle("Requested", for: .normal)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    func getImages() -> [String] {
        if self.artistDetail.artistImages?.count ?? 0 > 0 {
            return (self.artistDetail.artistImages?.map({$0.image ?? ""}))!
        }
        return [String]()
    }
    

    
    @IBAction func removeArtistButtonAction(_ sender: Any) {
//        let deleteArtistPopUp = DeleteArtistPopUpVC()
//        deleteArtistPopUp.artistDetail = self.artistDetail
//        deleteArtistPopUp.delegate = self
//        deleteArtistPopUp.modalPresentationStyle = .overFullScreen
//        self.navigationController?.present(deleteArtistPopUp, animated: true, completion: nil)
        
        if let topVC = UIApplication.getTopViewController() {
            topVC.popActionAlert(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.deleteServiceProvider, actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                self.hitRemoveArtistApi()
            },{
                cancel in
                self.dismiss(animated: false, completion: nil)
            }])
            
        }
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ArtistDetailedVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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


extension ArtistDetailedVC: DeleteArtistPopUpVCDelegate {
    func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
