//
//  BusinessEditProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 11/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class BusinessEditProfile: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var imgUploadBtn: UIButton!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var businessView: UIView!
    @IBOutlet weak var passwordSuperView: UIView!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var businessTYpeView: UIView!
    @IBOutlet weak var businessTypeTF: UITextField!
    @IBOutlet weak var dropdownImgView: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var headerNameLbl: UILabel!
    
    
    var data: BusinessData?
    var imagePicker: ImagePicker!
    var pickerData: PickerData?
    var businessTypeIndex: Int = -1
    let values = ["auto","data","meta","carry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        textFieldInterationDisable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: FUNCTIONS
    func configureUI() {
        businessTF.delegate = self
        businessTypeTF.delegate = self
        emailTF.delegate = self
        addressTF.delegate = self
        passwordTF.delegate = self
        descriptionTF.delegate = self
        self.userImgView.layer.cornerRadius = userImgView.frame.height/2
        userImgView.clipsToBounds = true
        passwordSuperView.isHidden = true
        setUIData()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        businessView.addCornerBorderAndShadow(view: businessView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        businessTYpeView.addCornerBorderAndShadow(view: businessTYpeView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        passwordView.addCornerBorderAndShadow(view: passwordView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        addressView.addCornerBorderAndShadow(view: addressView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionView.addCornerBorderAndShadow(view: descriptionView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
    }
    
    func textFieldInterationEnable() {
        self.headerNameLbl.text = "Edit Business Profile"
        editProfile.isHidden = true
        editProfile.isUserInteractionEnabled = false
        businessTF.isUserInteractionEnabled = true
        businessTypeTF.isUserInteractionEnabled = true
        emailTF.isUserInteractionEnabled = true
        passwordTF.isUserInteractionEnabled = true
        addressTF.isUserInteractionEnabled = true
        descriptionTF.isUserInteractionEnabled = true
        saveBtn.isHidden = false
        self.dropdownBtn.isHidden = false
        self.dropdownImgView.isHidden = false
        self.imgUploadBtn.isHidden = false
    }
    
    func textFieldInterationDisable() {
        self.headerNameLbl.text = "Business Profile"
        editProfile.isHidden = false
        editProfile.isUserInteractionEnabled = true
        businessTF.isUserInteractionEnabled = false
        businessTypeTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        passwordTF.isUserInteractionEnabled = true
        addressTF.isUserInteractionEnabled = false
        descriptionTF.isUserInteractionEnabled = false
        saveBtn.isHidden = true
        self.dropdownBtn.isHidden = true
        self.dropdownImgView.isHidden = true
        self.imgUploadBtn.isHidden = true
    }
    
    func setUIData() {
        if let data = data {
            self.businessTF.text = data.businessName
            //            self.businessTypeTF.text = data.typeId
            if let typeId: Int = Int(UserDefaultsCustom.getBusinessData()?.businessTypeId ?? "") {
                businessTypeTF.text = values[typeId]
                businessTypeIndex = typeId
            }
            self.emailTF.text = data.email
            //            self.passwordTF.text = data.password
            self.addressTF.text = data.businessAddress
            self.descriptionTF.text = data.businessDescription
            let placeHolder = UIImage(named: "placeHolder")
            self.userImgView.setImage(url: data.image, placeHolder: placeHolder)
            self.setPickerData(image: self.userImgView.image)
        }
    }

    func setPickerData(image: UIImage?) {
        let jpegData = image?.jpegData(compressionQuality: 0.5)
        self.pickerData = PickerData()
        self.pickerData?.image = image
        self.pickerData?.data = jpegData
    }

    
    func generatingParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["businessName"] = businessTF.text
        params["email"] = emailTF.text
        params["password"] = passwordTF.text
        params["businessType"] = businessTypeIndex // Int(businessTypeTF.text ?? "")
        params["businessAddress"] = addressTF.text
        params["businessDescription"] = descriptionTF.text
        return params
    }
    
    //MARK: Hit Edit Profile API
    func hitEditProfileApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.editBusinessProfile, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                UserDefaultsCustom.saveLogInData(data: data)
                Singleton.setHomeScreenView()

//                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
//                    UserDefaultsCustom.saveLogInData(data: data)
//                    Singleton.setHomeScreenView()
//
////                    if let data = response.data {
////                        UserDefaultsCustom.saveUserData(userData: data)
////                        Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
////                        if let tabBar = self.tabBarController as? TabBarVC {
////                            print("tab bar is \(tabBar)")
////                            tabBar.updateProfileImage()
////                        }
////                        self.navigationController?.popViewController(animated: true)
////                    }
//                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
            ActivityIndicator.sharedInstance.hideActivityIndicator()
        }
    }
    
    
    func actionType() {
        let picker = CustomPickerController()
        picker.selectedIndex = businessTypeIndex
        picker.set(values, delegate: self, tag: 0)
        self.present(picker, animated: false, completion: nil)
    }
    
    
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: businessTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessName, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: businessTypeTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterBusinessType, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTF.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }
//        else if ValidationManager.shared.isEmpty(text: passwordTF.text) == true {
//            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterPassword, isError: .error)
//        }
        else if ValidationManager.shared.isEmpty(text: addressTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterAddress, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: descriptionTF.text) == true{
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }else {
            hitEditProfileApi()
//            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: BUTTON ACTIONS
    
    @IBAction func backBtn(_ sender: UIButton) {
        textFieldInterationDisable()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileBtn(_ sender: UIButton) {
        textFieldInterationEnable()
    }
    
    @IBAction func imgUploadBtn(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
         validate()
    }
    
  
    
}


//    MARK: TEXTFIELD DELEGATES
extension BusinessEditProfile: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        businessTYpeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        passwordView.layer.borderColor = textField == passwordTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        switch textField {
//        case businessTypeTF:
//            self.actionType()
//        default:
//            break
//        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        businessView.layer.borderColor = textField == businessTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTYpeView.layer.borderColor = textField == businessTypeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordView.layer.borderColor = textField == passwordTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addressView.layer.borderColor = textField == addressTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        switch textField {
        case businessTypeTF:
            self.actionType()
            return false
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        businessView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        businessTYpeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
extension BusinessEditProfile: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

extension BusinessEditProfile: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.userImgView.image = image
            self.setPickerData(image: image)
        }
    }
    
}

extension BusinessEditProfile: CustomPickerControllerDelegate {
    func didSelectPicker(_ value: String, _ index: Int, _ image: String?, _ tag: Int?, custom picker: CustomPickerController) {
        print("values are ***** \(value) *** \(index) *** \(tag)  ****** \(image)")
        if tag == 0 {
            businessTypeTF.text = value
            businessTypeIndex = index
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func cancel(picker: CustomPickerController, _ tag: Int) {
        
    }
    
}
