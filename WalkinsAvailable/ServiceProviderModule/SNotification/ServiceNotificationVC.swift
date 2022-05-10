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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ServiceNotificationVC: UITableViewDataSource, UITableViewDelegate {
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
