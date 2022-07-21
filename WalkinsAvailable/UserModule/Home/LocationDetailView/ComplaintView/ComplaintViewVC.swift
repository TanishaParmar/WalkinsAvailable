//
//  ComplaintViewVC.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//

import UIKit

class ComplaintViewVC: UIViewController,UITextViewDelegate,UITextFieldDelegate {

//    MARK: OUTLETS
    @IBOutlet weak var shopNameView: UIView!
    @IBOutlet weak var shopNameTF: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var complaintView: UIView!
    
    var data: BusinessData = BusinessData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
    }

    @IBAction func saveBtn(_ sender: UIButton) {
        validate()
//            return
//        }else{
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    func uiUpdate(){
        self.shopNameTF.delegate = self
        self.descriptionField.delegate = self
        self.shopNameTF.text = self.data.businessName
        self.shopNameTF.isUserInteractionEnabled = false
        self.descriptionView.addCornerBorderAndShadow(view: self.descriptionView, cornerRadius: 4, shadowColor: .clear, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), borderWidth: 1)
        self.shopNameView.addCornerBorderAndShadow(view: self.shopNameView, cornerRadius: 4, shadowColor: .clear, borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), borderWidth: 1)
        self.saveBtn.addCornerRadius(view: self.saveBtn, cornerRadius: 4)
        self.complaintView.addCornerRadius(view: self.complaintView, cornerRadius: 20)
        self.complaintView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func generatingArtistHomeParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["businessId"] = self.data.businessId
        params["compDescription"] =  self.descriptionField.text
        debugPrint("params data ** \(params)")
        return params
    }

    
    //MARK: Hit Business Complaint API
    func hitBusinessComplaintApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.addComplaint, params: generatingArtistHomeParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: FavUnFavModel.self) {
                        if let msg = response.message {
                            Singleton.shared.showErrorMessage(error: msg, isError: .success)
                            self.dismiss(animated: true)
                        }
                    }
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
    }
    
//    MARK: VALIDATION
    func validate()  {
        if ValidationManager.shared.isEmpty(text: shopNameTF.text) {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessName, isError: .error)
        } else if ValidationManager.shared.isEmpty(text: descriptionField.text) {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterComplaint, isError: .error)
        } else if descriptionField.text == "Complaint...." {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterComplaint, isError: .error)
        } else {
            hitBusinessComplaintApi()
        }
    }
    //    MARK: TEXTFIELD DELEGATES
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.shopNameTF.isUserInteractionEnabled = false
//            shopNameView.layer.borderColor = textField == shopNameTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
//            shopNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
//            self.shopNameTF.isUserInteractionEnabled = false
            return true
        }
    
    //    MARK: TEXTVIEW DELEGATES
        func textViewDidBeginEditing(_ textView: UITextView) {
            self.descriptionView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }

}
