//
//  AvailbilityVC.swift
//  WalkinsAvailable
//
//  Created by apple on 03/05/22.
//

import UIKit

class AvailbilityVC: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var availbilityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availbilityTableView.delegate = self
        availbilityTableView.dataSource = self
        let nib = UINib(nibName: "AvailbilityListCell", bundle: nil)
        availbilityTableView.register(nib, forCellReuseIdentifier: "AvailbilityListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AvailbilityVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailbilityListCell", for: indexPath) as! AvailbilityListCell
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editAvailability), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @objc func editAvailability(sender : UIButton) {
        let controller = SetAvailbilityVC()
        controller.isNav = true
        self.push(viewController: controller)
    }
    
    
}
