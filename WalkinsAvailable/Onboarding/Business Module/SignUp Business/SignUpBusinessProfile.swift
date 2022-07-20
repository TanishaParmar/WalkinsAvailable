//
//  SignUpBusinessProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 27/04/22.
//

import UIKit
//import IQKeyboardManagerSwift
class SignUpBusinessProfile: SocialLoginVC {
    
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
    @IBOutlet weak var passwordSuperView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var socialLogInView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var socialLogInViewHeight: NSLayoutConstraint!
    
    var pickerData: PickerData?
    var imagePicker: ImagePicker!
    var userId: String = ""
    var emailId: String = ""
    var businessTypeIndex: Int = -1
    var coordi: (latitude: Double, longitude: Double)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.type = .business
        uiUpdate()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        IQKeyboardManager.shared.enable = true
    }
    
    
//    override func observeSuccessGoogleLogin() {
//        self.businessTF.text = 
//    }
    
    
    //    MARK: STORYBOARD_UPDATE
    func uiUpdate() {
        self.businessTF.delegate = self
        self.businessTypeTF.delegate = self
        self.emailTF.delegate = self
        self.passwordTf.delegate = self
        self.addressTF.delegate = self
        self.descriptionTextView.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if userId != "" {
            self.passwordSuperView.isHidden = true
            self.emailTF.text = emailId
            self.emailTF.isUserInteractionEnabled = false
            socialLogInView.isHidden = true
            socialLogInViewHeight.constant = 0
        }
        if !(Singleton.shared.categoryList?.count ?? 0 > 0) {
            getCategoryListData()
        }
        profileImageView.addCornerRadius(view: profileImageView, cornerRadius: profileImageView.frame.size.height / 2)
        businessView.addCornerBorderAndShadow(view: businessView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        businessTypeView.addCornerBorderAndShadow(view: businessTypeView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        passwordView.addCornerBorderAndShadow(view: passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        addressView.addCornerBorderAndShadow(view: addressView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionView.addCornerBorderAndShadow(view: descriptionView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
    }
    
    func getCategoryListData() {
        ApiHandler.updateProfile(apiName: API.Name.categoriesList, params: [:]) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: CategoryListModel.self) {
                    if let data = response.data {
                        Singleton.shared.categoryList = data
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                }
            }
        }
    }
    
    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["userId"] = userId
        params["businessName"] = businessTF.text
        params["email"] = emailTF.text
        params["password"] = passwordTf.text
        params["businessType"] = businessTypeIndex // Int(businessTypeTF.text ?? "")
        params["businessAddress"] = addressTF.text
        params["businessDescription"] = descriptionTextView.text
        params["latitude"] = coordi?.latitude // "30.7110585"
        params["longitude"] = coordi?.longitude // "76.6913124"
        params["deviceToken"] = UserDefaultsCustom.getDeviceToken()
        params["deviceType"] = "1"

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
                        UserDefaultsCustom.saveUserLogin(loginType: "2")
                        UserDefaultsCustom.saveLogInData(data: data)
                        Singleton.setHomeScreenView()
//                        if let data = response.data {
//                            UserDefaultsCustom.saveUserData(userData: data)
//                            Singleton.setHomeScreenView()
//                            UserDefaults.standard.set("business", forKey: "loginType")
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
    
    func openLocationPicker() {
        let locale = LocationPicker()
        locale.delegate = self
        self.present(locale, animated: true, completion: nil)
    }
    
    func actionType() {
        let picker = CustomPickerController()
//        picker.selectedIndex = businessTypeIndex
        var values = [String]()
        Singleton.shared.categoryList?.forEach({ categoryList in
            values.append(categoryList.title ?? "")
        })
        picker.set(values, delegate: self, tag: 0)
        self.present(picker, animated: false, completion: nil)
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
        }else if ValidationManager.shared.isEmpty(text: addressTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterAddress, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }else if self.pickerData == nil {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.chooseImage, isError: .error)
        }else if userId == "" && ValidationManager.shared.isEmpty(text: passwordTf.text) == true {
//            if ValidationManager.shared.isEmpty(text: passwordTf.text) == true {
                Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
//            }
        }else {
            hitBusinessSignUpApi()
            //            Singleton.setHomeScreenView()
        }
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadProfileActionBtn(_ sender: UIButton) {
        if self.imagePicker.checkCameraAccess() {
        self.imagePicker.present(from: sender)
        } 
    }
    
    @IBAction func dropDownBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        self.validate()
    }
    
}


extension SignUpBusinessProfile: LocationPickerDelegate {
    func locationDidSelect(locationItem: LocationItem) {
        print("location picked******** \(locationItem.formattedAddressString)")
        print("location picker coordinates ******** \(locationItem.coordinate?.latitude), \(locationItem.coordinate?.longitude)")
        self.addressTF.text = locationItem.formattedAddressString
        self.coordi = locationItem.coordinate
    }
}

//    MARK: TEXTFIELD DELEGATES
extension SignUpBusinessProfile: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.becomeFirstResponder()
//        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        businessTypeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        passwordView.layer.borderColor = textField == passwordTf ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        if textField == self.businessTypeTF {
//            self.businessTypeTF.resignFirstResponder()
//            self.actionType()
//        }
//    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTypeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTf ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        switch textField {
        case businessTypeTF:
            self.view.endEditing(true)
            self.actionType()
            return false
        case addressTF:
            self.view.endEditing(true)
            self.openLocationPicker()
            return false
        default:
            return true
        }
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
        if let image = image {
            self.profileImageView.image = image
            let jpegData = image.jpegData(compressionQuality: 0.5)
            self.pickerData = PickerData()
            self.pickerData?.image = image
            self.pickerData?.data = jpegData
        }
    }
    
}


extension SignUpBusinessProfile: CustomPickerControllerDelegate {
    func didSelectPicker(_ value: String, _ index: Int, _ image: String?, _ tag: Int?, custom picker: CustomPickerController) {
        print("values are ***** \(value) *** \(index) *** \(tag)  ****** \(image)")
        if tag == 0 {
            businessTypeTF.text = value
            businessTypeIndex = Int(Singleton.shared.categoryList?[index].businessTypeId ?? "") ?? 0
        }
        businessTypeTF.resignFirstResponder()
        self.view.endEditing(true)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func cancel(picker: CustomPickerController, _ tag: Int) {
        businessTypeTF.resignFirstResponder()
        self.view.endEditing(true)
    }
    
}
