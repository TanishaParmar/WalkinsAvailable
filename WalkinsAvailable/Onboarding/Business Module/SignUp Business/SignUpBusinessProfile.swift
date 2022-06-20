//
//  SignUpBusinessProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
import IQKeyboardManagerSwift
class SignUpBusinessProfile: UIViewController {
    
    var isNAv:Bool?
    //    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var uploadProfileBtn: UIButton!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var businessTypeView: UIView!
    @IBOutlet weak var businessTypeTF: UITextField!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    
    var pickerData: PickerData?
    var imagePicker: ImagePicker!
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //    MARK: STORYBOARD_UPDATE
    
    func uiUpdate() {
        self.businessTF.delegate = self
        self.businessTypeTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTf.delegate = self
        self.addressTF.delegate = self
        self.descriptionTextView.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        profileImageView.addCornerRadius(view: profileImageView, cornerRadius: profileImageView.frame.size.height / 2)
        businessView.addCornerBorderAndShadow(view: businessView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        businessTypeView.addCornerBorderAndShadow(view: businessTypeView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        passwordView.addCornerBorderAndShadow(view: passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        addressView.addCornerBorderAndShadow(view: addressView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionView.addCornerBorderAndShadow(view: descriptionView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
    }
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["userId"] = userId
        params["businessName"] = businessTF.text
        params["email"] = emailTF.text
        params["password"] = passwordTf.text
        params["businessType"] = Int(businessTypeTF.text ?? "")
        params["businessAddress"] = addressTF.text
        params["businessDescription"] = descriptionTextView.text
        params["latitude"] = "30.7110585"
        params["longitude"] = "76.6913124"
        debugPrint("params data ** \(params)")
        return params
    }
    
    //MARK: Hit Sign Up API
    func hitBusinessSignUpApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessSignUp, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                    if self.userId == "" {
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        if let data = response.data {
                            UserDefaultsCustom.saveUserData(userData: data)
                            Singleton.setHomeScreenView(userType: .business)
                        }
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
        if ValidationManager.shared.isEmpty(text: businessTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessName, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: businessTypeTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessType, isError: .error)
        }else  if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTF.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: passwordTf.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: addressTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterAddress, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }else {
            hitBusinessSignUpApi()
            //            Singleton.setHomeScreenView(userType: .business)
        }
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadProfileActionBtn(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func dropDownBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        self.validate()
    }
    
    
    
    
}


//    MARK: TEXTFIELD DELEGATES
extension SignUpBusinessProfile: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTypeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTf ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTypeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//    MARK: TEXTVIEW DELEGATES
extension SignUpBusinessProfile: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}


extension SignUpBusinessProfile: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.profileImageView.image = image
        let jpegData = image?.jpegData(compressionQuality: 0.5)
        self.pickerData = PickerData()
        self.pickerData?.image = image
        self.pickerData?.data = jpegData
    }
    
}
