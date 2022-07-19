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
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var businessLabel: UILabel!
    @IBOutlet weak var serviceProviderLabel: UILabel!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var businessButton: UIButton!
    @IBOutlet weak var serviceProviderButton: UIButton!
    
    
    var type: String = "1"
    
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
        eventUpdate()
    }
    
    
    func eventUpdate() {
        eventLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func businessUpdate(){
        eventLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func serviceProviderUpdate(){
        eventLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }

    
    //MARK:  hit Favorite api
    func hitFavoriteApi() {
//        self.eventsList.removeAll()
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.ongoingPastMycreateEvent, params: ["type":type]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: EventListModel.self) {
                    if let data = response.data {
//                        self.eventsList = data
//                        self.eventListTableView.reloadData()
                    }
                }
//                Singleton.shared.showErrorMessage(error: "success", isError: .success)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
//                    self.eventListTableView.reloadData()
                }
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func eventButtonAction(_ sender: Any) {
        eventUpdate()
    }
    
    @IBAction func businessButtonAction(_ sender: Any) {
        businessUpdate()
    }
    
    
    @IBAction func serviceProviderAction(_ sender: Any) {
        serviceProviderUpdate()
    }
    
    
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

