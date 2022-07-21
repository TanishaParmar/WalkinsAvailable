//
//  BusinessComplaintDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessComplaintDetailVC: UIViewController {
//    MARK: OUTLETS
    
    @IBOutlet weak var complaintView: UIView!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var complaintDescriptionLabel: UILabel!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var markResolvedButton: UIButton!
    @IBOutlet weak var backBtnOutlets: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var businesComplaintTableView: UITableView!
    
    
    var businessComplaintData: BusinessComplaintData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func registerCell() {
        businesComplaintTableView.delegate = self
        businesComplaintTableView.dataSource = self
        let nib = UINib(nibName: "BusinessComplaintdetailCell", bundle: nil)
        businesComplaintTableView.register(nib, forCellReuseIdentifier: "BusinessComplaintdetailCell")
    }
    
    func configureUI() {
        self.replyTextView.delegate = self
        self.complaintView.addCornerBorderAndShadow(view: self.complaintView, cornerRadius: 10, shadowColor: .clear, borderColor: .gray, borderWidth: 1.0)
        self.replyView.addCornerBorderAndShadow(view: self.replyView, cornerRadius: 10, shadowColor: .clear, borderColor: .gray, borderWidth: 1.0)
        self.saveButton.addCornerRadius(view: self.saveButton, cornerRadius: 5)
        
        if let userData = businessComplaintData?.userDetails {
            self.userNameLabel.text = userData.userName
        }
        let date = String().convertTimeStampToString(timeStamp: self.businessComplaintData?.created ?? "", format: "dd MMM YYYY, hh:mm")
        self.dateTimeLabel.text = date
        self.complaintDescriptionLabel.text = self.businessComplaintData?.compDescription
//        self.replyLabel.text = self.businessComplaintData?.complaintReply
//        self.pendingResolvedLabel.text = self.businessComplaintData?.status == "0" ? "Pending" : "Resolved"
    }
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["complaintId"] = self.businessComplaintData?.complaintId
        params["complaintReply"] = replyTextView.text
        params["status"] = self.markResolvedButton.isSelected ? "1" : "0"
        return params
    }
    
    func hitReplyApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessComplaintReply, params: generatingParameters()) { succeeded, response, data in
            debugPrint("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .success)
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }

    
    func validate() {
        if replyTextView.text == "" || replyTextView.text == "Reply...." {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterReply, isError: .error)
        }else {
            hitReplyApi()
        }
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func markResolvedButtonACtion(_ sender: Any) {
        markResolvedButton.isSelected = !markResolvedButton.isSelected
    }
    

    @IBAction func saveButtonAction(_ sender: Any) {
        validate()
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
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 397
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    
}


extension BusinessComplaintDetailVC: UITextViewDelegate {
    //    MARK: TEXTVIEW DELEGATES
        func textViewDidBeginEditing(_ textView: UITextView) {
            self.replyView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
        }
    
        func textViewDidEndEditing(_ textView: UITextView) {
            self.replyView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }


}
