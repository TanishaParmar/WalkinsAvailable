//
//  SignUpAsUserVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/4/22.
//


import UIKit
import IQKeyboardManagerSwift

class SignUpAsUserVC: SocialLoginVC {
    
    
    //MARK: Outlets
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordSuperView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInWithMailButton: UIButton!
    @IBOutlet weak var logInWithFacebookButton: UIButton!
    @IBOutlet weak var logInWithInstaButton: UIButton!
    @IBOutlet weak var socialLogInView: UIView!
    @IBOutlet weak var socialLogInViewHeight: NSLayoutConstraint!
    
    
    //MARK: Properties
    var pickerData: PickerData?
    var imagePicker: ImagePicker!
    var userId: String = ""
    var emailId: String = ""
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.type = .user
        self.tabBarController?.tabBar.isHidden = true

    }
    
    //MARK: Methods
    func configureUI() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.userNameView.addCornerBorderAndShadow(view: self.userNameView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.passwordView.addCornerBorderAndShadow(view: self.passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.logInButton.addCornerRadius(view: self.logInButton, cornerRadius: 5.0)
        self.profileImageView.addCornerRadius(view: self.profileImageView, cornerRadius: self.profileImageView.bounds.height / 2)
    }
    
    func setUI() {
        if userId != "" {
            self.passwordSuperView.isHidden = true
            self.emailTextField.text = emailId
            self.emailTextField.isUserInteractionEnabled = false
            socialLogInView.isHidden = true
            socialLogInViewHeight.constant = 0
        }
    }
    
    func generatingParameters() -> [String:Any] {
        let current = LocationManager.shared.currentLocation?.coordinate
        var params : [String:Any] = [:]
        params["userId"] = userId //UserDefaultsCustom.getUserData()?.userId
        params["userName"] = userNameTextField.text
        params["email"] = emailTextField.text
        params["password"] = passwordTextField.text
        params["latitude"] = current?.latitude // "30.7110585"
        params["longitude"] = current?.longitude // "76.6913124"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()
        params["deviceType"] = "1"
        return params
    }
    
    //MARK: Hit Sign Up API
    func hitSignUpApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.signUp, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            debugPrint("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                    if self.userId == "" {
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        UserDefaultsCustom.saveUserLogin(loginType: "1")
                        UserDefaultsCustom.saveLogInData(data: data)
                        Singleton.setHomeScreenView()

//                        if let data = response.data {
//                            UserDefaultsCustom.saveUserData(userData: data)
//                            Singleton.setHomeScreenView()
//                        }
                    }
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
        if ValidationManager.shared.isEmpty(text: userNameTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterUserName, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTextField.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else if userId == "" && ValidationManager.shared.isEmpty(text: passwordTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
        }else if (self.profileImageView.image == nil) {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseImage, isError: .error)
        }else if self.pickerData == nil {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseImage, isError: .error)
        }else {
            hitSignUpApi()
//            Singleton.setHomeScreenView()
        }
    }
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagePickerButtonAction(_ sender: UIButton) {
        if self.imagePicker.checkCameraAccess() {
        self.imagePicker.present(from: sender)
        }
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



extension SignUpAsUserVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.profileImageView.image = image
            let jpegData = image.jpegData(compressionQuality: 0.5)
            self.pickerData = PickerData()
            self.pickerData?.image = image
            self.pickerData?.data = jpegData
        }
    }
}
