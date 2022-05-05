//
//  SignUpBusinessProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
import IQKeyboardManagerSwift
class SignUpBusinessProfile: UIViewController,UITextFieldDelegate,UITextViewDelegate {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var uploadProfileBtn: UIButton!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var businessTypeView: UIView!
    @IBOutlet weak var businessTypeTF: UITextField!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadProfileActionBtn(_ sender: UIButton) {
    
    }
    
    @IBAction func dropDownBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
//        if validate() == false {
//            return
//        }else{
//            Singleton.setHomeScreenView(userType: .business)
//        }
        Singleton.setHomeScreenView(userType: .business)

        

    }
    
//    MARK: STORYBOARD_UPDATE
    
    func uiUpdate(){
        self.businessTF.delegate = self
        self.businessTypeTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTf.delegate = self
        self.addressTF.delegate = self
        self.descriptionTextView.delegate = self
        self.businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.businessView.layer.borderWidth = 1
        self.businessTypeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.businessTypeView.layer.borderWidth = 1
        self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.emailView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.passwordView.layer.borderWidth = 1
        self.addressView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.addressView.layer.borderWidth = 1
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.descriptionView.layer.borderWidth = 1
    }
    
//    MARK: VAILDATIONS
    func validate() -> Bool {
        if ValidationManager.shared.isEmpty(text: businessTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter business name.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: businessTypeTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter business type.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter email.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: passwordTf.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter password.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: addressTF.text) == true{
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter address.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true{
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter description.", okButton: "OK", controller: self) {
                
            }
            return false
        }
        
        return true
    }
    
//    MARK: TEXTFIELD DELEGATES
    func textFieldDidBeginEditing(_ textField: UITextField) {
        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTypeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTf ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTypeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
