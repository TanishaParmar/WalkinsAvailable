//
//  LoginVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/2/22.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FacebookLogin
import MapKit

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
        GIDSignIn.sharedInstance()?.presentingViewController = self
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .signInGoogleCompleted, object: nil)
    }
    
    //MARK: add Observer
    func addObserver() {
        NotificationCenter.default.addObserver(self,selector: #selector(userDidSignInGoogle(_:)), name: .signInGoogleCompleted, object: nil)
    }
    
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        if let dict = notification.userInfo?["googleUserInfo"] as? GIDGoogleUser {
            print("dict =>", dict)
            hitGoogleLogInApi(dict: dict)
        }
    }
    
    
    func facebookLogIN() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
        })
    }
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]
                // Facebook Id
                let facebookId = data["id"] as? String ?? ""
                let facebookName = data["name"] as? String ?? ""
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                let facebookEmail = data["email"] as? String ?? ""
                self.hitFacebookLogInApi(with: facebookEmail, userName: facebookName, facebookToken: facebookId, facebookImage: facebookProfilePicURL)
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }
    
    func generatingGoogleLogInParameters(dict: GIDGoogleUser) -> [String:Any] {
        var params : [String:Any] = [:]
        params["userName"] = dict.profile.name
        params["email"] = dict.profile.email
        params["image"] = dict.profile.imageURL(withDimension:500)
        params["googleToken"] = dict.userID
        params["latitude"] = "30.7110585"
        params["longitude"] = "76.6913124"
        params["deviceType"] = "1"
        debugPrint("params ****** \(params)")
        return params
    }
    
    //MARK: Hit Google Log In API
    func hitGoogleLogInApi(dict: GIDGoogleUser) {
        ApiHandler.updateProfile(apiName: API.Name.googleLogIn, params: generatingGoogleLogInParameters(dict: dict)) { succeeded, response, data in
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    if let data = response.data {
                        UserDefaultsCustom.saveUserData(userData: data)
                        Singleton.setHomeScreenView(userType: .user)
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    //MARK: Hit Facebook Log In API
    func hitFacebookLogInApi(with email: String, userName: String,facebookToken: String, facebookImage: String) {
        let params = ["userName":userName,"email":email,"image":facebookImage,"facebookToken":facebookToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
        debugPrint("params ****** \(params)")
        ApiHandler.updateProfile(apiName: API.Name.facebookLogIn, params: params) { succeeded, response, data in
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    if let data = response.data {
                        UserDefaultsCustom.saveUserData(userData: data)
                        Singleton.setHomeScreenView(userType: .user)
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["email"] = emailTextField.text
        params["password"] = passwordTextField.text
        params["latitude"] = "30.7110585"
        params["longitude"] = "76.6913124"
        params["deviceType"] = "1"
        return params
    }
    
    //MARK: Hit API
    func hitLogInApi() {
        ApiHandler.updateProfile(apiName: API.Name.login, params: generatingParameters()) { succeeded, response, data in
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    if let data = response.data {
                        UserDefaultsCustom.saveUserData(userData: data)
                        Singleton.setHomeScreenView(userType: .user)
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterEmail, okButton: "OK", controller: self) {
            }
        }else if emailTextField.text!.isValidEmail == false {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.validEmail , okButton: "Ok", controller: self) {
            }
        }else if ValidationManager.shared.isEmpty(text: passwordTextField.text) == true {
            showAlertMessage(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.enterPassword, okButton: "OK", controller: self) {
            }
        }else {
            hitLogInApi()
            //            Singleton.setHomeScreenView(userType: .user)
        }
    }
    
    //MARK: Actions
    @IBAction func logInButtonAction(_ sender: Any) {
        //        validate()
        Singleton.setHomeScreenView(userType: .user)
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
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookLogInButtonAction(_ sender: Any) {
        facebookLogIN()
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
