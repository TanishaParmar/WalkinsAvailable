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
    
    //MARK: VALIDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterEmail, okButton: "OK", controller: self) {
            }
        }else if emailTextField.text!.isValidEmail == false {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.validEmail , okButton: "Ok", controller: self) {
            }
        }else {
            self.navigationController?.popViewController(animated: true)
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
