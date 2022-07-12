//
//  BusinessEventVC.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessEventVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var businessEventTableView: UITableView!
    
    var eventsData: [InviteEventDetail]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessEventTableView.delegate = self
        businessEventTableView.dataSource = self
        let nib = UINib(nibName: "EventListCell", bundle: nil)
        businessEventTableView.register(nib, forCellReuseIdentifier: "EventListCell")
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension BusinessEventVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! EventListCell
        let eventList = self.eventsData?[indexPath.row].eventDetail
        cell.setEventDetail(eventList: eventList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EventDetailVC()
        controller.isFromEventList = false
        controller.eventId = self.eventsData?[indexPath.row].eventId
        self.push(viewController: controller)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 84
//    }
    
}
