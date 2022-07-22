//
//  ComplaintsVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/15/22.
//


import UIKit
import IQKeyboardManagerSwift
class ComplaintsVC: UIViewController {
    
//    var listArr:[String] = ["Pending","Pending","Resolve","Pending","Resolve","Pending"]
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var userType : USER_TYPE = .business
    var businessComplaintData: [BusinessComplaintData] = [BusinessComplaintData]()
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    var pageNo:Int = 0

    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        hitBusinessComplaintApi()
    }
    
    //MARK: Actions
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ComplaintsListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ComplaintsListCell")
    }
    
    
    func generatingArtistHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["perPage"] = "20"
        params["pageNo"] =  "\(pageNo+1)"
        debugPrint("params data ** \(params)")
        return params
    }

    
    //MARK: Hit Business Complaint API
    func hitBusinessComplaintApi() {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true

//        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessComplaintList, params: generatingArtistHomeParameters()) { succeeded, response, data in
            print("response data ** \(response)")
            self.isFetchingData = false
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: BusinessComplaintListModel.self) {
                    if let data = response.data {
                        if data.count > 0 {
                            self.isDataCompleted = data.count < 20
                            self.pageNo = self.pageNo + 1
                            self.businessComplaintData.append(contentsOf: data)
                            self.tableView.backgroundView = nil
                            self.tableView.reloadData()
                            
                        } else {
                            if self.businessComplaintData.count > 0 {
                                self.tableView.backgroundView = nil
                            } else {
                                self.tableView.setBackgroundView(message: "No Service Provider found.")
                            }
                            self.isDataCompleted = true
                            self.tableView.reloadData()
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
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
        
    
}

extension ComplaintsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessComplaintData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsListCell", for: indexPath) as! ComplaintsListCell
        switch userType {
        case .user:
            cell.setUIForUser(businessComplaintData: self.businessComplaintData[indexPath.row])
        case .business:
            cell.setUIForBusiness(businessComplaintData: self.businessComplaintData[indexPath.row])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (self.businessComplaintData.count-1) == indexPath.row else { return }
        self.hitBusinessComplaintApi()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch userType {
        case .user:
            let vc = ComplaintDetailVC()
            vc.businessComplaintData = self.businessComplaintData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case .business:
            let vc = BusinessComplaintDetailVC()
            vc.businessComplaintData = self.businessComplaintData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

