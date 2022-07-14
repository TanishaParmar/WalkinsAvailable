//
//  ServiceNotificationVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ServiceNotificationVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var notificationListtableView: UITableView!
    
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
        self.tabBarController?.tabBar.isHidden = true
        hitServiceProvierNotificationApi()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureUI() {
        notificationListtableView.dataSource = self
        notificationListtableView.delegate = self
        notificationListtableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "NotificationListTVC", bundle: nil)
        notificationListtableView.register(nib, forCellReuseIdentifier: "NotificationListTVC")
        self.notificationListtableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 50, right: 0)
    }
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["role"] = "3"
        params["perPage"] = "20"
        params["pageNo"] = "\(self.pageNo+1)"
        return params
    }
    
    //MARK: Hit Business Notification API
    func hitServiceProvierNotificationApi() {
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
                                self.notificationListtableView.backgroundView = nil
                                self.notificationListtableView.reloadData()

                            } else {
                                if self.serviceProviderNotificationData.count > 0 {
                                    self.notificationListtableView.backgroundView = nil
                                } else {
                                    self.notificationListtableView.setBackgroundView(message: "No data found.")
                                }
                                self.isDataCompleted = true
                                self.notificationListtableView.reloadData()
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
            "role": "3",
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
//                    self.serviceProviderNotificationData.removeAll(where: $0 == serviceProviderNotificationData?.notificationType ?? "")
                    print("before", self.serviceProviderNotificationData.count)
                    self.serviceProviderNotificationData.removeAll(where: { $0.notificationId == serviceProviderNotificationData?.notificationId })
                    print("after", self.serviceProviderNotificationData.count)
                    self.notificationListtableView.reloadData()
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
//                        Singleton.shared.showErrorMessage(error: msg, isError: .message)
                    }
                }
//            }
        }
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ServiceNotificationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.serviceProviderNotificationData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTVC", for: indexPath) as! NotificationListTVC
//        cell.statusView.isHidden = true
//        cell.authorLbl.isHidden = true
//        cell.statusheightConstraint.constant = 0
//        cell.authorheighConstraint.constant = 0
        cell.setUIElements(serviceProviderNotificationData: self.serviceProviderNotificationData[indexPath.row], delegate: self)
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


extension ServiceNotificationVC: NotificationListTVCDelegate {
    func acceptRequest(serviceProviderNotificationData: ServiceProviderNotificationData?) {
        hitAcceptRejectApi(serviceProviderNotificationData: serviceProviderNotificationData, type: "1")
    }
    
    func rejectRequest(serviceProviderNotificationData: ServiceProviderNotificationData?) {
        hitAcceptRejectApi(serviceProviderNotificationData: serviceProviderNotificationData, type: "2")
    }
    
    
}
