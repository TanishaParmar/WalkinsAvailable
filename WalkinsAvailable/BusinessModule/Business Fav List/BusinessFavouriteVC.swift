//
//  BusinessFavouriteVC.swift
//  WalkinsAvailable
//
//  Created by apple on 03/05/22.
//

import UIKit

class BusinessFavouriteVC: UIViewController {

    var imgArr:[String] = ["logo1234","logo12","logo1234","logo12","logo1234"]
    
//    MARK: OUTLETS
    @IBOutlet weak var businessFavouriteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    func configureUI() {
        businessFavouriteTableView.dataSource = self
        businessFavouriteTableView.delegate = self
        businessFavouriteTableView.rowHeight = UITableView.automaticDimension
        businessFavouriteTableView.estimatedRowHeight = 60
        let nib = UINib(nibName: "BusinessFavouriteList", bundle: nil)
        businessFavouriteTableView.register(nib, forCellReuseIdentifier: "BusinessFavouriteList")
    }

}
extension BusinessFavouriteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessFavouriteList", for: indexPath) as! BusinessFavouriteList
        cell.imgCell.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
  
    
    
    

}
