//
//  NotificationVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class NotificationVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var notificationListingTableView: UITableView!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //MARK: Methods
    func configureUI() {
        notificationListingTableView.dataSource = self
        notificationListingTableView.delegate = self
        notificationListingTableView.rowHeight = UITableView.automaticDimension
        notificationListingTableView.estimatedRowHeight = 60
        let nib = UINib(nibName: "NotificationListTVC", bundle: nil)
        notificationListingTableView.register(nib, forCellReuseIdentifier: "NotificationListTVC")
    }
    
    
    //MARK: Actions
    
    
    
    
}



extension NotificationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTVC", for: indexPath) as! NotificationListTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120// UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    
}
