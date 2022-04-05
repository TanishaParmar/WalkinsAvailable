//
//  LoginVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/2/22.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    //MARK: Methods
    func configureUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.emailTextFieldView.addCornerBorderAndShadow(view: self.emailTextFieldView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.passwordTextFieldView.addCornerBorderAndShadow(view: self.passwordTextFieldView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.logInButton.addCornerRadius(view: self.logInButton, cornerRadius: 5.0)
    }
    
    
    
    //MARK: Actions

    @IBAction func logInButtonAction(_ sender: Any) {
        let viewcontroller = TabBarVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let viewcontroller = ForgotPasswordVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func emailLogInButtonAction(_ sender: Any) {
    
    }
    
    @IBAction func facebookLogInButtonAction(_ sender: Any) {
    
    }
    
    @IBAction func instaLogInButtonAction(_ sender: Any) {
        
    }
    
}

extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextFieldView.layer.borderColor = textField == emailTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextFieldView.layer.borderColor = textField == passwordTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextFieldView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextFieldView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
