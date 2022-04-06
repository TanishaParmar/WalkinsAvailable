//
//  FavouriteVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class FavouriteVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var favouriteListingTableView: UITableView!
    
    
        //MARK: VC Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configureUI()
    }
    
    
    //MARK: Methods
    func configureUI() {
        favouriteListingTableView.dataSource = self
        favouriteListingTableView.delegate = self
        let nib = UINib(nibName: "FavouriteListTVC", bundle: nil)
        favouriteListingTableView.register(nib, forCellReuseIdentifier: "FavouriteListTVC")
    }
    
    
    //MARK: Actions
    
    
    
    
}

extension FavouriteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteListTVC", for: indexPath) as! FavouriteListTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

