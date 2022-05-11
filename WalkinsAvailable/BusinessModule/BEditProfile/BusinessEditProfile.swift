//
//  BusinessEditProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 11/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class BusinessEditProfile: UIViewController,UITextFieldDelegate,UITextViewDelegate {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var imgUploadBtn: UIButton!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var businessTYpeView: UIView!
    @IBOutlet weak var businessTypeTF: UITextField!
    @IBOutlet weak var dropdownImgView: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var headerNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        textFieldInterationDisable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    //MARK: BUTTON ACTIONS
    
    @IBAction func backBtn(_ sender: UIButton) {
        textFieldInterationDisable()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileBtn(_ sender: UIButton) {
        textFieldInterationEnable()
    }
    
    @IBAction func imgUploadBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        if validate() == false {
            return
        }else{
            print("its work")
        }
    }
    
    //MARK: FUNCTIONS
    
    func configureUI(){
        businessTF.delegate = self
        businessTypeTF.delegate = self
        emailTF.delegate = self
        addressTF.delegate = self
        passwordTF.delegate = self
        descriptionTF.delegate = self
        self.userImgView.layer.cornerRadius = userImgView.frame.height/2
        userImgView.clipsToBounds = true
        self.businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.businessView.layer.borderWidth = 1
        self.businessTYpeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.businessTYpeView.layer.borderWidth = 1
        self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.emailView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.passwordView.layer.borderWidth = 1
        self.addressView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.addressView.layer.borderWidth = 1
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.descriptionView.layer.borderWidth = 1
    }
    func textFieldInterationEnable(){
        self.headerNameLbl.text = "Edit Business Profile"
        businessTF.isUserInteractionEnabled = true
        businessTypeTF.isUserInteractionEnabled = true
        emailTF.isUserInteractionEnabled = true
        passwordTF.isUserInteractionEnabled = true
        addressTF.isUserInteractionEnabled = true
        descriptionTF.isUserInteractionEnabled = true
        self.dropdownBtn.isHidden = false
        self.dropdownImgView.isHidden = false
        self.imgUploadBtn.isHidden = false
    }
    
    func textFieldInterationDisable(){
        self.headerNameLbl.text = "Business Profile"
        businessTF.isUserInteractionEnabled = false
        businessTypeTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        passwordTF.isUserInteractionEnabled = true
        addressTF.isUserInteractionEnabled = false
        descriptionTF.isUserInteractionEnabled = false
        self.dropdownBtn.isHidden = true
        self.dropdownImgView.isHidden = true
        self.imgUploadBtn.isHidden = true
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
            if ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
                showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter password.", okButton: "OK", controller: self) {
                    
                }
                return false
            }
            if ValidationManager.shared.isEmpty(text: addressTF.text) == true{
                showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter address.", okButton: "OK", controller: self) {
                    
                }
                return false
            }
            if ValidationManager.shared.isEmpty(text: descriptionTF.text) == true{
                showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter description.", okButton: "OK", controller: self) {
                    
                }
                return false
            }
            
            return true
        }
    
    //    MARK: TEXTFIELD DELEGATES
        func textFieldDidBeginEditing(_ textField: UITextField) {
            businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            businessTYpeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            passwordView.layer.borderColor = textField == passwordTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            businessTYpeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
