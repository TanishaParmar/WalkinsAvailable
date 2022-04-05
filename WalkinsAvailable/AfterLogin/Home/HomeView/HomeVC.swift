//
//  HomeVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class HomeVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var listingCollectionView: UICollectionView!
    
    
    //MARK: Properties
    var listArr: [(String, String, UIColor)] = [("Barber","barber", #colorLiteral(red: 0.991193831, green: 0.6588253379, blue: 0.5455851555, alpha: 1)),("Coffee","coffee", #colorLiteral(red: 0.7385370731, green: 0.6313439012, blue: 0.9501467347, alpha: 1)),("Makeup","makeup", #colorLiteral(red: 0.9670820832, green: 0.6249657273, blue: 0.8386198878, alpha: 1)),("Restaurant","restaurant", #colorLiteral(red: 1, green: 0.6488577724, blue: 0.6619021297, alpha: 1)),("Shopping","shopping", #colorLiteral(red: 0.9555502534, green: 0.8837473989, blue: 0.4137159288, alpha: 1)),("Tatto","tatto", #colorLiteral(red: 0.4223589599, green: 0.8335838318, blue: 0.7735235095, alpha: 1))]
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    //MARK: Methods
    func configureUI() {
        listingCollectionView.dataSource = self
        listingCollectionView.delegate = self
        let nib = UINib(nibName: "HomeListCVC", bundle: nil)
        listingCollectionView.register(nib, forCellWithReuseIdentifier: "HomeListCVC")
    }
    
    
    //MARK: Actions
    
    
    
    
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCVC", for: indexPath) as! HomeListCVC
        cell.titleLabel.text = listArr[indexPath.item].0
        let img = UIImage(named: listArr[indexPath.item].1)
        cell.logoImageView.image = img
        cell.mainView.backgroundColor = listArr[indexPath.item].2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.35
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 18, bottom: 20, right: 18)
    }
}
