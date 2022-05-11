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
        notificationTblView.dataSource = self
        notificationTblView.delegate = self
        notificationTblView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "NotificationListTVC", bundle: nil)
        notificationTblView.register(nib, forCellReuseIdentifier: "NotificationListTVC")
    }

}
extension BusinessNotificationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListTVC", for: indexPath) as! NotificationListTVC
            if indexPath.row == 2{
                cell.statusView.isHidden = false
                cell.authorLbl.isHidden = false
                cell.statusheightConstraint.constant = 30
                cell.authorheighConstraint.constant = 20
            }else{
       
            cell.statusView.isHidden = true
            cell.authorLbl.isHidden = true
            cell.statusheightConstraint.constant = 0
            cell.authorheighConstraint.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
