//
//  BusinessComplaintDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessComplaintDetailVC: UIViewController {
//    MARK: OUTLETS
    
    @IBOutlet weak var backBtnOutlets: UIButton!
    @IBOutlet weak var businesComplaintTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businesComplaintTableView.delegate = self
        businesComplaintTableView.dataSource = self
        let nib = UINib(nibName: "BusinessComplaintdetailCell", bundle: nil)
        businesComplaintTableView.register(nib, forCellReuseIdentifier: "BusinessComplaintdetailCell")
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension BusinessComplaintDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessComplaintdetailCell", for: indexPath) as! BusinessComplaintdetailCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 397
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
