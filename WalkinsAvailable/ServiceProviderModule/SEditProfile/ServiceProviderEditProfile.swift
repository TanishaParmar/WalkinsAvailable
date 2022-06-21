//
//  ServiceProviderEditProfile.swift
//  WalkinsAvailable
//
//  Created by apple on 10/05/22.
//

import UIKit

class ServiceProviderEditProfile: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var profilrImgView: UIImageView!
    @IBOutlet weak var editProfileImgVw: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var artistView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var artistNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    var imagePicker: ImagePicker!
    var pickerData: PickerData?
    var data: UserData?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func uiUpdate(){
        self.artistNameTF.delegate = self
        self.emailTF.delegate = self
        self.descriptionTextView.delegate = self
        setUIData()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        profilrImgView.addCornerRadius(view: profilrImgView, cornerRadius: profilrImgView.bounds.height / 2)
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        artistView.addCornerBorderAndShadow(view: artistView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionTextView.addCornerBorderAndShadow(view: descriptionTextView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        saveBtn.addCornerRadius(view: saveBtn, cornerRadius: 5)
    }
    
    func setUIData() {
        if let data = data {
            self.artistNameTF.text = data.name
            self.emailTF.text = data.email
            self.descriptionTextView.text = data.description
            let placeHolder = UIImage(named: "")
            self.profilrImgView.setImage(url: data.image, placeHolder: placeHolder)
            self.setPickerData(image: self.profilrImgView.image)
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
        params["artistName"] = artistNameTF.text
        params["email"] = emailTF.text
        return params
    }
    
    //MARK: Hit Edit Profile API
    func hitEditProfileApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.editArtistProfile, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    if let data = response.data {
                        UserDefaultsCustom.saveUserData(userData: data)
                        Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                        self.navigationController?.popViewController(animated: true)
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
        }else  if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTF.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }
//        else if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true {
//            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
//        }
        else {
            hitEditProfileApi()
//            self.navigationController?.popViewController(animated: true)
        }
    }
    

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileImgVw(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        validate()
    }
    

}


//    MARK: TEXTFIELD DELEGATES
extension ServiceProviderEditProfile: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        artistView.layer.borderColor = textField == artistNameTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        artistView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}

//    MARK: TEXTVIEW DELEGATES
extension ServiceProviderEditProfile: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionTextView.layer.borderColor = #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}


extension ServiceProviderEditProfile: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.profilrImgView.image = image
        self.setPickerData(image: image)
    }
    
}
