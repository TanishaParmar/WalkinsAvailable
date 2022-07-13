//
//  InviteFromShopVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class InviteFromShopVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var inviteSearchBar: UISearchBar!
    @IBOutlet weak var requestInvitetableView: UITableView!
    
    var searchBusinessData: [SearchBusinessData] = [SearchBusinessData]()
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    var timer: Timer?
    var pageNo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitSearchBusinessApi(searchText: "")
    }
    
    //MARK: Actions
    func configureUI() {
        requestInvitetableView.dataSource = self
        requestInvitetableView.delegate = self
        inviteSearchBar.delegate = self
        let nib = UINib(nibName: "RequestInviteFromCell", bundle: nil)
        requestInvitetableView.register(nib, forCellReuseIdentifier: "RequestInviteFromCell")
        self.requestInvitetableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 50, right: 0)
    }
    
    //MARK: hit Search Business Api
    func hitSearchBusinessApi(searchText: String) {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true

        let params:[String: Any] = [
            "search": searchText,
            "perPage": "20",
            "pageNo": "\(self.pageNo+1)"
        ]
        ApiHandler.updateProfile(apiName: API.Name.businessSearch, params: params) { succeeded, response, data in
            self.isFetchingData = false
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: SearchBusinessResponse.self) {
                    if let data = response.data {
                        if data.count > 0 {
                            self.isDataCompleted = data.count < 20
                            self.pageNo = self.pageNo + 1
                            self.searchBusinessData.append(contentsOf: data)
                            self.requestInvitetableView.backgroundView = nil
                            self.requestInvitetableView.reloadData()
                            
                        } else {
                            if self.searchBusinessData.count > 0 {
                                self.requestInvitetableView.backgroundView = nil
                            } else {
                                self.requestInvitetableView.setBackgroundView(message: "No data found.")
                            }
                            self.isDataCompleted = true
                            self.requestInvitetableView.reloadData()
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
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: hit Search Business Api
extension InviteFromShopVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchBusinessData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestInviteFromCell", for: indexPath) as! RequestInviteFromCell
        let businessData = self.searchBusinessData[indexPath.row]
        cell.setUIElements(businessData: businessData, delegate: self)
        return cell
    }
    
    
func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard (self.searchBusinessData.count-1) == indexPath.row else { return }
    self.hitSearchBusinessApi(searchText: self.inviteSearchBar.text ?? "")
}
    
}


//MARK: hit Search Business Api
extension InviteFromShopVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            if self.searchBusinessData.count > 0 {
                self.searchBusinessData.removeAll()
                self.requestInvitetableView.reloadData()
            }
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchText(_:)), userInfo: searchText, repeats: false)
    }
    
    @objc func searchText(_ timer: Timer) {
        guard let searchKey = timer.userInfo as? String else { return }
        self.pageNo = 0
        self.isDataCompleted = false
        self.isFetchingData = false
        self.hitSearchBusinessApi(searchText: searchKey)
    }
}


extension InviteFromShopVC: RequestInviteFromCellDelegate {
    func requestToBustiness(businessData: SearchBusinessData?, sender: UIButton) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        //MARK: Hit Business Home API
        ApiHandler.updateProfile(apiName: API.Name.businessRequest, params: ["businessId": businessData?.businessId ?? ""]) { succeeded, response, dataRes in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                businessData?.isJoin = "Requested"
                sender.setTitle("Requested", for: .normal)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
}
