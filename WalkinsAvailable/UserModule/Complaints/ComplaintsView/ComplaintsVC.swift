//
//  ComplaintsVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/15/22.
//


import UIKit
import IQKeyboardManagerSwift
class ComplaintsVC: UIViewController {
    
    var listArr:[String] = ["Pending","Pending","Resolve","Pending","Resolve","Pending"]
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Actions
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ComplaintsListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ComplaintsListCell")
    }
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
        
    
}

extension ComplaintsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsListCell", for: indexPath) as! ComplaintsListCell
        cell.userProfileView.layer.cornerRadius = cell.userProfileView.frame.height / 2
        cell.statusBtn.setTitle("\(listArr[indexPath.row])", for: .normal)
        cell.statusBtn.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ComplaintDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

