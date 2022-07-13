//
//  BusinessNotificationVC.swift
//  WalkinsAvailable
//
//  Created by apple on 03/05/22.
//

import UIKit

class BusinessNotificationVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var notificationTblView: UITableView!
    
    
    var serviceProviderNotificationData: [ServiceProviderNotificationData] = [ServiceProviderNotificationData]()
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    var pageNo: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hitBusinessNotificationApi()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("disappear")
        self.isDataCompleted = false
        self.isFetchingData = false
    }
    
    //MARK: Methods
    func configureUI() {
        notificationTblView.dataSource = self
        notificationTblView.delegate = self
        notificationTblView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "NotificationListTVC", bundle: nil)
        notificationTblView.register(nib, forCellReuseIdentifier: "NotificationListTVC")
    }
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["role"] = "2"
        params["perPage"] = "20"
        params["pageNo"] = "\(self.pageNo+1)"
        return params
    }
    
    //MARK: Hit Business Notification API
    func hitBusinessNotificationApi() {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true

        ApiHandler.updateProfile(apiName: API.Name.getAllNotificationByRole, params: generatingParameters()) { succeeded, response, data in
            self.isFetchingData = false
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: ServiceProviderNotificationResponse.self) {
                        if let data = response.data {
                            if data.count > 0 {
                                self.isDataCompleted = data.count < 20
                                self.pageNo = self.pageNo + 1
                                self.serviceProviderNotificationData.append(contentsOf: data)
                                self.notificationTblView.backgroundView = nil
                                self.notificationTblView.reloadData()

                            } else {
                                if self.serviceProviderNotificationData.count > 0 {
                                    self.notificationTblView.backgroundView = nil
                                } else {
                                    self.notificationTblView.setBackgroundView(message: "No data found.")
                                }
                                self.isDataCompleted = true
                                self.notificationTblView.reloadData()
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
    
    //MARK: Hit Business Home API
    func hitAcceptRejectApi(serviceProviderNotificationData: ServiceProviderNotificationData?, type: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params:[String: Any] = [
            "role": "2",
            "notificationId": serviceProviderNotificationData?.notificationId ?? 0,
            "type": type
        ]

        ApiHandler.updateProfile(apiName: API.Name.acceptRejectShopRequest, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
//            DispatchQueue.main.async {
                if succeeded {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .success)
                    }
                    print("before", self.serviceProviderNotificationData.count)
                    self.serviceProviderNotificationData.removeAll(where: { $0.notificationId == serviceProviderNotificationData?.notificationId })
                    print("after", self.serviceProviderNotificationData.count)
                    self.notificationTblView.reloadData()
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
//            }
        }
    }

}
extension BusinessNotificationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.serviceProviderNotificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTVC", for: indexPath) as! NotificationListTVC
        cell.setUIElements(serviceProviderNotificationData: self.serviceProviderNotificationData[indexPath.row], delegate: self)
//            if indexPath.row == 2{
//                cell.statusView.isHidden = false
//                cell.authorLbl.isHidden = false
//                cell.statusheightConstraint.constant = 30
//                cell.authorheighConstraint.constant = 20
//            }else{
//
//            cell.statusView.isHidden = true
//            cell.authorLbl.isHidden = true
//            cell.statusheightConstraint.constant = 0
//            cell.authorheighConstraint.constant = 0
//        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    
}


extension BusinessNotificationVC: NotificationListTVCDelegate {
    func acceptRequest(serviceProviderNotificationData: ServiceProviderNotificationData?) {
        hitAcceptRejectApi(serviceProviderNotificationData: serviceProviderNotificationData, type: "1")
    }
    
    func rejectRequest(serviceProviderNotificationData: ServiceProviderNotificationData?) {
        hitAcceptRejectApi(serviceProviderNotificationData: serviceProviderNotificationData, type: "2")
    }
    
    
}
