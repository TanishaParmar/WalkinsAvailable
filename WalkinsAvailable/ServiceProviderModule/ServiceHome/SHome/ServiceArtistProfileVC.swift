//
//  BusinessArtistProfileVC.swift
//  WalkinsAvailable
//
//  Created by apple on 04/05/22.
//

import UIKit

class ServiceArtistProfileVC: UIViewController {

    var imgArr:[String] = ["1ar","2ar","1ar","3ar","4ar","5ar","ghar","2ar","ghar","2ar","uu","uyyu","wqw","wwe","yyt","3ar","4ar","5ar","ghar","2ar"]
    
    @IBOutlet weak var collectionImgView: UICollectionView!
    @IBOutlet weak var artistImgView: UIImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var artistStatusButton: UISwitch!
    @IBOutlet weak var artistDescriptionLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var addArtistBtn: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var setAvailabilityBtn: UIButton!
    
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
    UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let padding: CGFloat =  collectionImgView.frame.size.width
      let collectionViewSize = collectionImgView.frame.size.width - 2
      return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListImgCell", for: indexPath) as! ArtistListImgCell
        cell.imgCell.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
}
