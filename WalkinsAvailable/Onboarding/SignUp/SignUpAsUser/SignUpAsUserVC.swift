//
//  SignUpAsUserVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/4/22.
//


import UIKit
import IQKeyboardManagerSwift

class SignUpAsUserVC: UIViewController {

    var isUser:Bool?
    
    //MARK: Outlets
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInWithMailButton: UIButton!
    @IBOutlet weak var logInWithFacebookButton: UIButton!
    @IBOutlet weak var logInWithInstaButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.tabBarController?.tabBar.isHidden = true

    }
    
    //MARK: Methods
    func configureUI() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.userNameView.addCornerBorderAndShadow(view: self.userNameView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.passwordView.addCornerBorderAndShadow(view: self.passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.logInButton.addCornerRadius(view: self.logInButton, cornerRadius: 5.0)
        self.profileImageView.addCornerRadius(view: self.profileImageView, cornerRadius: self.profileImageView.bounds.height / 2)
    }
    
    //MARK: VALIDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: userNameTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter user name.", okButton: "OK", controller: self) {
            }
        }else if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter email.", okButton: "OK", controller: self) {
            }
        }else if emailTextField.text!.isValidEmail == false {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter vaild email." , okButton: "Ok", controller: self) {
            }
        }else if ValidationManager.shared.isEmpty(text: passwordTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: "Please enter password.", okButton: "OK", controller: self) {
            }
        }else {
            Singleton.setHomeScreenView(userType: .user)
        }
    }
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        validate()
    }
    
    @IBAction func logInWithEmailButtonAction(_ sender: Any) {
    }
    
    @IBAction func logInWithFacebookButtonAction(_ sender: Any) {
    }
    
    @IBAction func logInWithInstaButtonAction(_ sender: Any) {
    }
    
    
}

extension SignUpAsUserVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameView.layer.borderColor = textField == userNameTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
