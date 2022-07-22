//
//  LocationDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import UIKit

class LocationDetailVC: PresentableController {
    
//    var imgArr:[String] = ["img1","img2","img3","img4","img5"]
    
//    MARK: OUTLETS
    @IBOutlet weak var favImgView: UIImageView!
    @IBOutlet weak var commentView: UIImageView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var favUnfavButton: UIButton!
    @IBOutlet weak var locationImgView: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var locationAddressLbl: UILabel!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var locationDescriptionLbl: UILabel!
    @IBOutlet weak var locationStatusLbl: UILabel!
    @IBOutlet weak var waitingTimeLbl: UILabel!
    @IBOutlet weak var noArtistLabel: UILabel!
    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var locationDetailView: UIView!
    
    var parentVC:MapController?
    var data: BusinessData = BusinessData()
    var artistsList : [ArtistData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.artistCollectionView.delegate = self
        self.artistCollectionView.dataSource = self
        let nib = UINib(nibName: "ArtistListCell", bundle: nil)
        artistCollectionView.register(nib, forCellWithReuseIdentifier: "ArtistListCell")
        self.contentView = self.locationDetailView
    }
    
    
    func configureUI(){
        self.locationDetailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        self.locationDetailView.addCornerBorderAndShadow(view: self.locationDetailView, cornerRadius: 20, shadowColor: .red, borderColor: .clear, borderWidth: 0.0)
        self.locationStatusLbl.addCornerBorderAndShadow(view: self.locationStatusLbl, cornerRadius: 4, shadowColor: .clear, borderColor: .gray, borderWidth: 1.0)
        applyShadowAndRadius()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.uiUpdate()
        }
//        uiUpdate()
    }
    
    func applyShadowAndRadius() {
        self.locationDetailView.layer.masksToBounds = false
        self.locationDetailView.layer.cornerRadius = 20
        self.locationDetailView.layer.shadowColor = UIColor.black.cgColor
        self.locationDetailView.layer.shadowPath = UIBezierPath(roundedRect: self.locationDetailView.bounds, cornerRadius: self.locationDetailView.layer.cornerRadius).cgPath
        self.locationDetailView.layer.shadowOffset = CGSize(width: 0.0, height: -100.0)
        self.locationDetailView.layer.shadowOpacity = 0.08
        self.locationDetailView.layer.shadowRadius = 30.0

    }
    
    func uiUpdate() {
//        self.businessName.text = self.data.businessName
        self.locationNameLbl.text = self.data.businessName
        self.locationDescriptionLbl.text = self.data.businessDescription
        self.locationAddressLbl.text = self.data.businessAddress
        self.locationStatusLbl.text = self.data.businessAvailability == "1" ? "Available" : "Unavailable"
        self.favUnfavButton.isSelected = self.data.isFav == "1"
        self.locationImgView.setImage(url: self.data.image, placeHolder: UIImage(named: ""))
        self.artistsList = self.data.artistsList ?? []
        if artistsList.count > 0 {
            artistCollectionView.isHidden = false
            noArtistLabel.isHidden = true
        } else {
            artistCollectionView.isHidden = true
            noArtistLabel.isHidden = false
        }
        self.artistCollectionView.reloadData()
    }
    
    
    func generatingFavnFavParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["businessId"] = self.data.businessId
        params["role"] = "2"
        print(params)
        return params
    }
    
    
    //MARK: Hit Fav Unfav API
    func hitFavUnFavApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.favUnfavBusinessArtist, params: generatingFavnFavParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: FavUnFavModel.self) {
                    if let isFav = response.isFav {
                        self.favUnfavButton.isSelected = isFav == "1"
                    }
                }
                print(response)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    

    @IBAction func commentBtn(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let controller = ComplaintViewVC()
            controller.data = self.data
            self.parentVC?.present(controller, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func favUnfavButtonAction(_ sender: Any) {
//        favUnfavButton.isSelected = !favUnfavButton.isSelected
        hitFavUnFavApi()
    }
    
}

extension LocationDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistsList.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListCell", for: indexPath) as! ArtistListCell
        cell.setUI(artistsList: self.artistsList[indexPath.row], delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            let controller = ArtistProfileVC()
            controller.artistId = self.artistsList[indexPath.row].artistId ?? ""
            self.parentVC?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 5)
        print(width)
        return CGSize(width: width, height: width + 30)
    }
    
    
}

extension LocationDetailVC: ArtistListCellDelegate {
    
}
