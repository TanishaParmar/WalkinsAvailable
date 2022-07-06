//
//  EventVC.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import UIKit

class EventVC: UIViewController {

// MARK: OUTLETS
    
    @IBOutlet weak var ongoingBtn: UIButton!
    @IBOutlet weak var pastBtn: UIButton!
    @IBOutlet weak var myCreateBtn: UIButton!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var pastLbl: UILabel!
    @IBOutlet weak var myCreateLbl: UILabel!
    @IBOutlet weak var eventListTableView: UITableView!
    
    
    var eventsList: [EventsList] = [EventsList]()
    var type: String = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        hitEventsApi()
    }
    
    //    MARK: Methods

    func configureUI() {
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
        let nib = UINib(nibName: "EventListCell", bundle: nil)
        eventListTableView.register(nib, forCellReuseIdentifier: "EventListCell")
        self.eventListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        onGoingUpdate()
    }
        
    func onGoingUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func pastUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func myCreateUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }
    
    
    // hit events api
    func hitEventsApi() {
        self.eventsList.removeAll()
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.ongoingPastMycreateEvent, params: ["type":type]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: EventListModel.self) {
                    if let data = response.data {
                        self.eventsList = data
                        self.eventListTableView.reloadData()
                    }
                }
//                Singleton.shared.showErrorMessage(error: "success", isError: .success)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    self.eventListTableView.reloadData()
                }
            }
        }
    }

//    MARK: BUTTON ACTIONS
     
    @IBAction func onCreateBtn(_ sender: UIButton) {
        let controller = EventCreateVC()
        self.push(viewController: controller)
    }
    
    
    @IBAction func ongoingBtn(_ sender: UIButton) {
       onGoingUpdate()
        type = "2"
        hitEventsApi()
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        pastUpdate()
        type = "3"
        hitEventsApi()
    }
    
    @IBAction func myCreateBtn(_ sender: UIButton) {
        myCreateUpdate()
        type = "4"
        hitEventsApi()
    }
    
}

extension EventVC : UITableViewDelegate, UITableViewDataSource {
    
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
        controller.eventId = self.eventsList[indexPath.row].eventId
        self.push(viewController: controller)
    }
    
    
}
