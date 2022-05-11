//
//  NotificationVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

var globalNotification = "1"
class NotificationVC: UIViewController {
        
    //MARK: Outlets
    @IBOutlet weak var notificationListingTableView: UITableView!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: Methods
    func configureUI() {
        notificationListingTableView.dataSource = self
        notificationListingTableView.delegate = self
        notificationListingTableView.rowHeight = UITableView.automaticDimension
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
        cell.statusView.isHidden = true
        cell.authorLbl.isHidden = true
        cell.statusheightConstraint.constant = 0
        cell.authorheighConstraint.constant = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
