//
//  BusinessHomeVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class BusinessHomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listArr:[String] = ["Invite Events","Nearby Events"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        let nib = UINib(nibName: "BusinessHomeListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BusinessHomeListCell")
    }
}


extension BusinessHomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessHomeListCell", for: indexPath) as! BusinessHomeListCell
        cell.btnSeeAll.tag = indexPath.row
        cell.btnSeeAll.addTarget(self, action: #selector(btnSeeAllAction), for: .touchUpInside)
        cell.headerLbl.text = listArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return 220
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = (Bundle.main.loadNibNamed("BusinessHomeHeaderView", owner: self, options: nil)![0] as? BusinessHomeHeaderView)
        view?.headerView()
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    @objc func btnSeeAllAction(sender : UIButton) {
        let controller = BusinessEventVC()
        self.push(viewController: controller)
    }
    
}
