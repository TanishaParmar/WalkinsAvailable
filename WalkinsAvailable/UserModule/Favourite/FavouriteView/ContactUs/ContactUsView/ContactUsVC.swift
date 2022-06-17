//
//  ContactUsVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//


import UIKit
import IQKeyboardManagerSwift

class ContactUsVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var data: UserData?
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: METHODS
    func configureUI() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.messageTextView.delegate = self
        setUIData()
        self.nameView.addCornerBorderAndShadow(view: self.nameView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.messageView.addCornerBorderAndShadow(view: self.messageView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.saveButton.addCornerRadius(view: self.saveButton, cornerRadius: 5.0)
    }
    
    func setUIData() {
        if let data = data {
            self.nameTextField.text = data.userName
            self.emailTextField.text = data.email
        }
        self.nameTextField.isUserInteractionEnabled = false
        self.emailTextField.isUserInteractionEnabled = false
    }
    
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["message"] = messageTextView.text
        return params
    }
    
    //MARK: Hit API
    func hitContactUsApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.contactUs, params: generatingParameters()) { succeeded, response, data in
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
    
    
    
    //MARK: VALIDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: messageTextView.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterOldPassword, isError: .error)
        } else {
            hitContactUsApi()
        }
    }
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        validate()
    }
    
    
}


extension ContactUsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameView.layer.borderColor = textField == nameTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


//    MARK: TEXTVIEW DELEGATES
extension ContactUsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.messageTextView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.messageTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}
