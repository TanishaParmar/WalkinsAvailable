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
    
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    var type: String = "1"
    var pageNo:Int = 0
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitFavoriteListingApi()
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
        type = "3"
        eventLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func businessUpdate() {
        type = "2"
        eventLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func serviceProviderUpdate() {
        type = "1"
        eventLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        businessLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        serviceProviderLabel.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }
    
    
    func generatingArtistHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["type"] = type
        params["perPage"] = "20"
        params["pageNo"] =  "\(pageNo+1)"
        debugPrint("params data ** \(params)")
        return params
    }
    
    
    //MARK: Hit Business Complaint API
    func hitFavoriteListingApi() {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true
        
        //        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.userFavoriteList, params: generatingArtistHomeParameters()) { succeeded, response, data in
            print("response data ** \(response)")
            self.isFetchingData = false
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: BusinessComplaintListModel.self) {
                    if let data = response.data {
                        if data.count > 0 {
                            self.isDataCompleted = data.count < 20
                            self.pageNo = self.pageNo + 1
                            //                            self.businessComplaintData.append(contentsOf: data)
                            //                            self.tableView.backgroundView = nil
                            //                            self.tableView.reloadData()
                            
                        } else {
                            //                            if self.businessComplaintData.count > 0 {
                            //                                self.tableView.backgroundView = nil
                            //                            } else {
                            //                                self.tableView.setBackgroundView(message: "No Service Provider found.")
                            //                            }
                            self.isDataCompleted = true
                            //                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard (self.businessComplaintData.count-1) == indexPath.row else { return }
//        self.hitBusinessComplaintApi()
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "1" {
            let controller = EventDetailVC()
            //            controller.isFromEventList = true
            //            controller.eventId = self.eventsList[indexPath.row].eventId
            self.push(viewController: controller)
        } else if type == "2" {
            let controller = LocationDetailVC()
            controller.modalPresentationStyle = .overFullScreen
            //            controller.data = data
            //            controller.parentVC = self
            self.navigationController?.present(controller, animated: true, completion: nil)
        } else if type == "3" {
            let controller = ArtistProfileVC()
            //            controller.artistId = self.artistsList[indexPath.row].artistId ?? ""
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

