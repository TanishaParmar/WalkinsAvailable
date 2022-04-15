//
//  ChangePasswordVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/15/22.
//


import UIKit

class ChangePasswordVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        self.oldPasswordView.addCornerBorderAndShadow(view: self.oldPasswordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.newPasswordView.addCornerBorderAndShadow(view: self.newPasswordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.confirmPasswordView.addCornerBorderAndShadow(view: self.confirmPasswordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.submitButton.addCornerRadius(view: self.submitButton, cornerRadius: 5.0)
    }
    
    
    //MARK: Actions
    
    @IBAction func submitButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func backButtonACtion(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension ChangePasswordVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        oldPasswordView.layer.borderColor = textField == oldPasswordTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        newPasswordView.layer.borderColor = textField == newPasswordTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        confirmPasswordView.layer.borderColor = textField == confirmPasswordTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        oldPasswordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        newPasswordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        confirmPasswordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}