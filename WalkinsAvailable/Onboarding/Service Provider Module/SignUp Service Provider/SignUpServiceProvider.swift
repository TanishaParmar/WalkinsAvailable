//
//  SignUpServiceProvider.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
import IQKeyboardManagerSwift
class SignUpServiceProvider: UIViewController {

    var isService:Bool?
    
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
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func uploadBtnProfile(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        validate()
    }
    
    //    MARK: STORYBOARD_UPDATE
    
    func uiUpdate() {
        self.businessTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        businessView.addCornerBorderAndShadow(view: businessView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        passwordView.addCornerBorderAndShadow(view: passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
    }
    
    
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: businessTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterArtistName, okButton: "OK", controller: self) {
            }
        }else  if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterEmail, okButton: "OK", controller: self) {
            }
        }else if emailTF.text!.isValidEmail == false {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.validEmail , okButton: "Ok", controller: self) {
            }
        }else if ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterPassword, okButton: "OK", controller: self) {
            }
        }else {
            Singleton.setHomeScreenView(userType: .serviceProvider )
        }
    }
    

    
    
}


//    MARK: TEXTFIELD DELEGATES
extension SignUpServiceProvider: UITextFieldDelegate {
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
