//
//  ServiceEventVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ServiceEventVC: UIViewController {
    
    @IBOutlet weak var ongoingAndPastDetailsView: UIView!
    @IBOutlet weak var pastEventsView: UIView!
    @IBOutlet weak var ongoingBtn: UIButton!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var pastBtn: UIButton!
    @IBOutlet weak var pastLbl: UILabel!
    @IBOutlet weak var ServiceEventListTableView: UITableView!
    
    var isFromSettings: Bool = false
    var eventsList: [EventsList] = [EventsList]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func ongoingBtn(_ sender: UIButton) {
        onGoingUpdate()
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        pastUpdate()
    }
    
    
    //    MARK: FUNCTIONS
    func configureUI() {
        ServiceEventListTableView.dataSource = self
        ServiceEventListTableView.delegate = self
        let nib = UINib(nibName: "EventListCell", bundle: nil)
        ServiceEventListTableView.register(nib, forCellReuseIdentifier: "EventListCell")
        if isFromSettings {
            pastEventsView.isHidden = false
            ongoingAndPastDetailsView.isHidden = true
            hitEventsApi(type: "1")
        } else {
            pastEventsView.isHidden = true
            ongoingAndPastDetailsView.isHidden = false
        }
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func onGoingUpdate() {
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func pastUpdate() {
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }
    
    // hit events api
    func hitEventsApi(type: String) {
        self.eventsList.removeAll()
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.ongoingPastMycreateEvent, params: ["type":type]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: EventListModel.self) {
                    if let data = response.data {
                        self.eventsList = data
                        self.ServiceEventListTableView.reloadData()
                    }
                }
                //                Singleton.shared.showErrorMessage(error: "success", isError: .success)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    self.ServiceEventListTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ServiceEventVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! EventListCell
        cell.setUIElements(eventData: self.eventsList[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 84
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EventDetailVC()
        self.push(viewController: controller)
    }
    
}

