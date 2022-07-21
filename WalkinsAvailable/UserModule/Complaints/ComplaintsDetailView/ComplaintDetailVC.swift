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
    
    @IBOutlet weak var complaintView: UIView!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replySuperView: UIView!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var complaintDescriptionLabel: UILabel!
    @IBOutlet weak var pendingResolvedLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var complaintDetailTableView: UITableView!
    
    var businessComplaintData: BusinessComplaintData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func registerCell(){
        complaintDetailTableView.delegate = self
        complaintDetailTableView.dataSource = self
        let nib = UINib(nibName: "ComplaintDetailCell", bundle: nil)
        complaintDetailTableView.register(nib, forCellReuseIdentifier: "ComplaintDetailCell")
    }

    func configureUI() {
        self.complaintView.addCornerBorderAndShadow(view: self.complaintView, cornerRadius: 10, shadowColor: .clear, borderColor: .gray, borderWidth: 1.0)
        self.replyView.addCornerBorderAndShadow(view: self.replyView, cornerRadius: 10, shadowColor: .clear, borderColor: .gray, borderWidth: 1.0)
        self.pendingResolvedLabel.addCornerRadius(view: self.pendingResolvedLabel, cornerRadius: self.pendingResolvedLabel.bounds.height / 2)
        
        if let businessData = businessComplaintData?.businessDetails {
            self.shopLabel.text = businessData.businessName
        }
        let date = String().convertTimeStampToString(timeStamp: self.businessComplaintData?.created ?? "", format: "dd MMM YYYY, hh:mm a")
        self.dateTimeLabel.text = date
        self.complaintDescriptionLabel.text = self.businessComplaintData?.compDescription
        self.replyLabel.text = self.businessComplaintData?.complaintReply
        self.replySuperView.isHidden = self.replyLabel.text == "" || self.replyLabel.text == nil
        self.pendingResolvedLabel.text = self.businessComplaintData?.status == "0" ? "Pending" : "Resolve"
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
