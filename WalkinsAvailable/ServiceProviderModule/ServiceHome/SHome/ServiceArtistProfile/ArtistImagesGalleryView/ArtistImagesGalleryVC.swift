//
//  ArtistImagesGalleryVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/18/22.
//

//import UIKit

//class ArtistImagesGalleryVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//}


//
//  ArtistImagesGalleryVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/18/22.
//

import UIKit
import Photos

//protocol CropImageVCDelegate {
//    func didSelectImages(_ images: [UIImage])
//}
/*
class ArtistImagesGalleryVC: UIViewController {
    
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var cropimageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pageController: UIPageViewController?
    var selected_images: [PHAsset]?
    var iselectEdit:Bool = true
    var arrayimages:[UIImage]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionCell()
        self.setupPageController()
    }
    
    func setCollectionCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerCell(identifier: "UploadImageCollectionCell")
        collectionView.backgroundColor = .clear
        
        self.arrayimages = self.getAssetThumbnail(assets: self.selected_images ?? [])
        if let image = self.arrayimages?.first {
//            self.setCropperController(image: image)
            self.cropimageView.image = image
        }
        self.collectionView.reloadData()
    }

    //MARK: Convert array of PHAsset to UIImages
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
             
            })
        }
        return arrayOfImages
    }
    
    func setCropperController(image: UIImage, index:Int) {
        if self.pageController == nil {
            self.setupPageController()
        }
        let cropper = CropperViewController(originalImage: image)
        cropper.view.tag = index
        cropper.delegate = self
        self.pageController?.setViewControllers([cropper], direction: .forward, animated: false)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.didSelectImages(self.arrayimages ?? [])
        }
    }
    
}

extension ArtistImagesGalleryVC: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayimages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadImageCollectionCell", for: indexPath) as? UploadImageCollectionCell else{return UICollectionViewCell()}
        let image = self.arrayimages?[indexPath.item]
        cell.uploadImage.image = image
//        cell.removeButton.tag = indexPath.item
//        cell.removeButton.addTarget(self, action: #selector(deletePost(_:)), for: .touchUpInside)
        cell.removeButton.isHidden = true
//        cell.backgroundColor = .clear
//        cell.contentView.backgroundColor = .clear
//        cell.uploadImage.backgroundColor = .clear
        return cell
    }
    
    @objc func deletePost(_ sender: UIButton) {
        self.selected_images?.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = self.arrayimages?[indexPath.row] {
        debugPrint("thumbmnail images are \(image)")
            self.setCropperController(image: image, index: indexPath.row)
        }
    }
    
}

//extension ArtistImagesGalleryVC: CropperViewControllerDelegate {
//    func cropperDidConfirm(_ cropper: CropperViewController, state: CropperState?) {
//        let index = cropper.view.tag
//        print("tag is \(cropper.view.tag) \(state)")
//        if let state = state,
//           let image = cropper.originalImage.cropped(withCropperState: state) {
//            self.cropimageView.image = image
//            self.arrayimages?[index] = image
//        } else {
//            print("Something went wrong")
//        }
//        self.removePageController()
//    }
//
//}


extension ArtistImagesGalleryVC {

    private func setupPageController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.view.backgroundColor = .clear
        self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChild(self.pageController!)
        self.pageController!.view.frame = self.imageBgView.bounds
        self.imageBgView.addSubview(self.pageController!.view)
        self.pageController?.didMove(toParent: self)
        self.pageController?.view.backgroundColor = .clear
    }
    
    private func removePageController() {
        guard self.pageController != nil else { return }
        self.pageController?.view.removeFromSuperview()
        self.pageController = nil
    }
    
    
}
*/
