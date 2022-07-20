//
//  HomeVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit
import IQKeyboardManagerSwift

class HomeVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var listingCollectionView: UICollectionView!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Methods
    func configureUI() {
        listingCollectionView.dataSource = self
        listingCollectionView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        let nib = UINib(nibName: "HomeListCVC", bundle: nil)
        listingCollectionView.register(nib, forCellWithReuseIdentifier: "HomeListCVC")
        self.navigationController?.navigationBar.isHidden = true
        
        if Singleton.shared.categoryList?.count ?? 0 == 0 {
            Singleton.shared.callBackCategoryListing = {
                DispatchQueue.main.async {
                    self.listingCollectionView.reloadData()
                    Singleton.shared.callBackCategoryListing = nil
                }
            }
        }
    }
    
    
    //MARK: Actions

}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Singleton.shared.categoryList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCVC", for: indexPath) as! HomeListCVC
        let categoryData = Singleton.shared.categoryList?[indexPath.row]
        cell.setUI(categoryData: categoryData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.35
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 18, bottom: 20, right: 18)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapVC = MapController()
        mapVC.businessTypeId = Singleton.shared.categoryList?[indexPath.row].businessTypeId
        self.push(viewController: mapVC)
    }
    
}
