//
//  SignUpServiceProvider.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
import IQKeyboardManagerSwift
class SignUpServiceProvider: UIViewController,UITextFieldDelegate {
    
    //    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var uploadBtnProfile: UIButton!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
    }
    
    @IBAction func uploadBtnProfile(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        if validate() == false {
            return
        }else{
            Singleton.setHomeScreenView(userType: .serviceProvider )
        }
    }
    
    //    MARK: STORYBOARD_UPDATE
    
    func uiUpdate(){
        self.businessTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        self.businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.businessView.layer.borderWidth = 1
        self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.emailView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.passwordView.layer.borderWidth = 1
    }
    
    //    MARK: VAILDATIONS
    func validate() -> Bool {
        if ValidationManager.shared.isEmpty(text: businessTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter business name.", okButton: "OK", controller: self) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter email.", okButton: "OK", controller: self) {
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter password.", okButton: "OK", controller: self) {
            }
            return false
        }
        return true
    }
    //    MARK: TEXTFIELD DELEGATES
    func textFieldDidBeginEditing(_ textField: UITextField) {
        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
