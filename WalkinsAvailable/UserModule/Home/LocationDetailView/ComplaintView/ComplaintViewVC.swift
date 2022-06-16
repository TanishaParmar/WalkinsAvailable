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
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.descriptionView.layer.borderWidth = 1
        self.descriptionView.layer.cornerRadius = 4
        self.descriptionView.clipsToBounds = true
        self.shopNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.shopNameView.layer.borderWidth = 1
        self.shopNameView.layer.cornerRadius = 4
        self.shopNameView.clipsToBounds = true
        self.saveBtn.layer.cornerRadius = 4
        self.saveBtn.clipsToBounds = true
        self.complaintView.clipsToBounds = true
        self.complaintView.layer.cornerRadius = 20
    
        self.complaintView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
//    MARK: VALIDATION
    
    func validate()  {
        if ValidationManager.shared.isEmpty(text: shopNameTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessName, isError: .error)
        }
        if ValidationManager.shared.isEmpty(text: descriptionField.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }
        
    }
    //    MARK: TEXTFIELD DELEGATES
        func textFieldDidBeginEditing(_ textField: UITextField) {
            shopNameView.layer.borderColor = textField == shopNameTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            shopNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
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
