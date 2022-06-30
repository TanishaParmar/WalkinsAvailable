//
//  SignUpServiceVC.swift
//  WalkinsAvailable
//
//  Created by apple on 10/05/22.
//

import UIKit

class SignUpServiceVC: SocialLoginVC {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userNameImgView: UIImageView!
    @IBOutlet weak var editProfileImgVw: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var artistNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var artistView: UIView!
    @IBOutlet weak var passwordSuperView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var socialLogInView: UIView!
    @IBOutlet weak var socialLogInViewHeight: NSLayoutConstraint!
    
    
    var pickerData: PickerData?
    var imagePicker: ImagePicker!
    var userId: String = ""
    var emailId: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.type = .serviceProvider
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: Methods
    func configureUI() {
        artistNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if userId != "" {
            self.passwordSuperView.isHidden = true
            self.emailTF.text = emailId
            self.emailTF.isUserInteractionEnabled = false
            socialLogInView.isHidden = true
            socialLogInViewHeight.constant = 0
        }
        userNameImgView.addCornerRadius(view: userNameImgView, cornerRadius: userNameImgView.bounds.height / 2)
        artistView.addCornerBorderAndShadow(view: artistView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        passwordView.addCornerBorderAndShadow(view: passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
    }
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["userId"] = userId
        params["artistName"] = artistNameTF.text
        params["email"] = emailTF.text
        params["password"] = passwordTF.text
//        params["latitude"] = "30.7110585"
//        params["longitude"] = "76.6913124"
        debugPrint("params data ** \(params)")
        return params
    }
    
    //MARK: Hit Sign Up API
    func hitArtistSignUpApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.artistSignUp, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                    if self.userId == "" {
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        UserDefaultsCustom.saveUserLogin(loginType: "3")
                        UserDefaultsCustom.saveLogInData(data: data)
                        Singleton.setHomeScreenView()

//                        if let data = response.data {
//                            UserDefaultsCustom.saveUserData(userData: data)
//                            Singleton.setHomeScreenView()
//                            UserDefaults.standard.set("serviceProvider", forKey: "loginType")
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

    
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: artistNameTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterArtistName, isError: .error)
        } else  if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        } else if emailTF.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        } else if self.pickerData == nil {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseImage, isError: .error)
        } else if userId == "" && ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
//            if ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
                Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
//            }
        } else {
            hitArtistSignUpApi()
//            Singleton.setHomeScreenView()
        }
    }
    
    
    
    //MARK: Action
    @IBAction func editBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileImgViewBtn(_ sender: UIButton) {
        if self.imagePicker.checkCameraAccess() {
        self.imagePicker.present(from: sender)
        } 
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        validate()
    }
    
}


extension SignUpServiceVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        artistView.layer.borderColor = textField == artistNameTF ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTF ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        artistView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension SignUpServiceVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.userNameImgView.image = image
            let jpegData = image.jpegData(compressionQuality: 0.5)
            self.pickerData = PickerData()
            self.pickerData?.image = image
            self.pickerData?.data = jpegData
        }
    }
    
}
