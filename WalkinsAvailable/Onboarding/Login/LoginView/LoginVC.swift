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
import AuthenticationServices


class LoginVC: SocialLoginVC {
    
    //MARK: Outlets
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func observeSuccessGoogleLogin() {
//        Singleton.setHomeScreenView()
    }
    
    
    
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
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        addObserver()
    }
    /*
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
    
    
    func actionAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.googleLogIn, params: generatingGoogleLogInParameters(dict: dict)) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                Singleton.setHomeScreenView()

//                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
//                    if let data = response.data {
//                        UserDefaultsCustom.saveUserData(userData: data)
//                        Singleton.setHomeScreenView()
//                        UserDefaults.standard.set("user", forKey: "loginType")
//                    }
//                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    //MARK: Hit Apple Log In API
    func hitAppleLogInApi(with email: String, userName: String,appleToken: String, appleImage: String) {
        let params = ["userName":userName,"email":email,"image":appleImage,"appleToken":appleToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
        debugPrint("params ****** \(params)")
        ApiHandler.updateProfile(apiName: API.Name.appleLogIn, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                Singleton.setHomeScreenView()
                
                
//                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
//                    if let data = response.data {
//                        UserDefaultsCustom.saveUserData(userData: data)
//                        Singleton.setHomeScreenView()
//                        UserDefaults.standard.set("user", forKey: "loginType")
//                    }
//                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    //MARK: Hit Facebook Log In API
    func hitFacebookLogInApi(with email: String, userName: String,facebookToken: String, facebookImage: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params = ["userName":userName,"email":email,"image":facebookImage,"facebookToken":facebookToken,"latitude":"30.7110585","longitude":"76.6913124","deviceType":"1"] as [String:Any]
        debugPrint("params ****** \(params)")
        ApiHandler.updateProfile(apiName: API.Name.facebookLogIn, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                Singleton.setHomeScreenView()

                
//                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
//                    if let data = response.data {
//                        UserDefaultsCustom.saveUserData(userData: data)
//                        Singleton.setHomeScreenView()
//                        UserDefaults.standard.set("user", forKey: "loginType")
//                    }
//                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }*/
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        let current = LocationManager.shared.currentLocation?.coordinate
        params["email"] = emailTextField.text
        params["password"] = passwordTextField.text
        params["latitude"] = current?.latitude // "30.7110585"
        params["longitude"] = current?.longitude // "76.6913124"
        params["deviceType"] = "1"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()
        return params
    }
    
    //MARK: Hit API
    func hitLogInApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.login, params: generatingParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                Singleton.setHomeScreenView()
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
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTextField.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: passwordTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
        }else {
            hitLogInApi()
            //            Singleton.setHomeScreenView()
        }
    }
    
    //MARK: Actions
    @IBAction func logInButtonAction(_ sender: Any) {
                validate()
//        Singleton.setHomeScreenView()
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let viewcontroller = ForgotPasswordVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
    @IBAction func appleLoginButtonAction(_ sender: Any) {
//        actionAppleSignin()
    }
    
    @IBAction func emailLogInButtonAction(_ sender: Any) {
//        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookLogInButtonAction(_ sender: Any) {
//        facebookLogIN()
    }
    
    @IBAction func instaLogInButtonAction(_ sender: Any) {
        
    }
    
}

//MARK: text field delegates
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
/*
//MARK: apple login delegates
extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let appleId = appleIDCredential.user ?? ""
            let appleUserFirstName = appleIDCredential.fullName?.givenName ?? ""
            let appleUserLastName = appleIDCredential.fullName?.familyName ?? ""
            let appleUserEmail = appleIDCredential.email ?? ""
            let userName = "\(appleUserFirstName) \(appleUserLastName)"
            //Write your code
            ActivityIndicator.sharedInstance.showActivityIndicator()
            hitAppleLogInApi(with: appleUserEmail, userName: userName, appleToken: appleId, appleImage: "")
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            print("password credentials are =>", passwordCredential)
        }
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
*/
