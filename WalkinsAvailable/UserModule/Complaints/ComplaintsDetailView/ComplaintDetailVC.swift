//
//  ComplaintDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
import IQKeyboardManagerSwift
class ComplaintDetailVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var complaintDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiUpdate()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func uiUpdate(){
        complaintDetailTableView.delegate = self
        complaintDetailTableView.dataSource = self
        let nib = UINib(nibName: "ComplaintDetailCell", bundle: nil)
        complaintDetailTableView.register(nib, forCellReuseIdentifier: "ComplaintDetailCell")
    }

}
extension ComplaintDetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintDetailCell", for: indexPath) as! ComplaintDetailCell
//        cell.replyUIview.isHidden = true
//        cell.btnUiview.isHidden = true
        return cell
    }
    
    
}
