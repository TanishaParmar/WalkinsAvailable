//
//  ForgotPasswordVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//


import UIKit

class ForgotPasswordVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
        emailTextField.delegate = self
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.saveButton.addCornerRadius(view: self.saveButton, cornerRadius: 5.0)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["email"] = emailTextField.text
        return params
    }
    
    //MARK: Hit API
    func hitForgotPasswordApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.forgetPassword, params: generatingParameters()) { succeeded, response, data in
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
        if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTextField.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else {
            hitForgotPasswordApi()
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        validate()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailView.layer.borderColor = textField == emailTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
