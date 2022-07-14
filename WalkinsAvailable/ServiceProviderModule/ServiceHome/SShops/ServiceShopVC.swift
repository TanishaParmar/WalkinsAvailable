//
//  ServiceShopVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ServiceShopVC: UIViewController {

    @IBOutlet weak var shopListTableView: UITableView!
    
    var associatedBusinessData: [SearchBusinessData] = [SearchBusinessData]()
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    var pageNo: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitAssociatedBusinessApi()
    }

    //MARK: Methods
    func configureUI() {
        shopListTableView.dataSource = self
        shopListTableView.delegate = self
        shopListTableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "ShopsListCell", bundle: nil)
        shopListTableView.register(nib, forCellReuseIdentifier: "ShopsListCell")
    }
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
//        params["role"] = "3"
        params["perPage"] = "20"
        params["pageNo"] = "\(self.pageNo+1)"
        return params
    }
    
    //MARK: Hit Associated Business API
    func hitAssociatedBusinessApi() {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true

        ApiHandler.updateProfile(apiName: API.Name.associatedBusiness, params: generatingParameters()) { succeeded, response, data in
            self.isFetchingData = false
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: AssociatedBusinessResponseModel.self) {
                        if let data = response.data {
                            if data.count > 0 {
                                self.isDataCompleted = data.count < 20
                                self.pageNo = self.pageNo + 1
                                self.associatedBusinessData.append(contentsOf: data)
                                self.shopListTableView.backgroundView = nil
                                self.shopListTableView.reloadData()

                            } else {
                                if self.associatedBusinessData.count > 0 {
                                    self.shopListTableView.backgroundView = nil
                                } else {
                                    self.shopListTableView.setBackgroundView(message: "No data found.")
                                }
                                self.isDataCompleted = true
                                self.shopListTableView.reloadData()
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
    }
    

}
extension ServiceShopVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.associatedBusinessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopsListCell", for: indexPath) as! ShopsListCell
        let associatedData = self.associatedBusinessData[indexPath.row]
        cell.setUI(associatedData: associatedData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopsDetailVC = ServiceShopDetailedVC()
        shopsDetailVC.associatedBusinessData = self.associatedBusinessData[indexPath.row]
        self.push(viewController: shopsDetailVC)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 86
//    }
    
    
}
