//
//  EditProfileVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//


import UIKit
import IQKeyboardManagerSwift

class EditProfileVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var camerButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    
    var data: UserData?
    var imagePicker: ImagePicker!
    var pickerData: PickerData?
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: Methods
    func configureUI() {
        userNameTextField.delegate = self
        emailTextField.delegate = self
        setData()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.userNameView.addCornerBorderAndShadow(view: self.userNameView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.saveButton.addCornerRadius(view: self.saveButton, cornerRadius: 5.0)
        self.profileImageView.addCornerRadius(view: self.profileImageView, cornerRadius: self.profileImageView.bounds.height / 2)
    }
    
    func setData() {
        if let data = data {
            self.userNameTextField.text = data.name
            self.emailTextField.text = data.email
            let placeHolder = UIImage(named: "placeHolder")
            self.profileImageView.setImage(url: data.image, placeHolder: placeHolder)
            self.setPickerData(image: self.profileImageView.image)
        }
        editScreen(isEditable: false)
    }
    
    func editScreen(isEditable: Bool) {
        if isEditable {
            self.titleLabel.text = "Edit User Profile"
            self.editButton.isHidden = true
            self.camerButton.isUserInteractionEnabled = false
            self.camerButton.isHidden = false
            self.camerButton.isUserInteractionEnabled = true
            self.userNameTextField.isUserInteractionEnabled = true
            self.emailTextField.isUserInteractionEnabled = true
            self.saveButton.isHidden = false
            self.saveButton.isUserInteractionEnabled = true
        } else {
            self.titleLabel.text = "User Profile"
            self.editButton.isHidden = false
            self.camerButton.isUserInteractionEnabled = true
            self.camerButton.isHidden = true
            self.camerButton.isUserInteractionEnabled = false
            self.userNameTextField.isUserInteractionEnabled = false
            self.emailTextField.isUserInteractionEnabled = false
            self.saveButton.isHidden = true
            self.saveButton.isUserInteractionEnabled = false
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
        params["name"] = userNameTextField.text
        params["email"] = emailTextField.text
        return params
    }
    
    //MARK: Hit Edit Profile API
    func hitEditProfileApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.editProfile, params: generatingParameters(), profilePhoto: self.pickerData) { succeeded, response, data in
            debugPrint("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: UserModel.self) {
                    if let data = response.data {
                        UserDefaultsCustom.saveUserData(userData: data)
                        Singleton.shared.showErrorMessage(error: response.message ?? "", isError: .success)
                        if let tabBar = self.tabBarController as? TabBarVC {
                            print("tab bar is \(tabBar)")
                            tabBar.updateProfileImage()
                        }
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
    
    func validate() {
        if ValidationManager.shared.isEmpty(text: userNameTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterUserName, isError: .error)
        }else  if ValidationManager.shared.isEmpty(text: emailTextField.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTextField.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else {
            hitEditProfileApi()
        }
    }
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
    editScreen(isEditable: true)
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        validate()
    }
    
    
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameView.layer.borderColor = textField == userNameTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = textField == emailTextField ? #colorLiteral(red: 0.9816923738, green: 0.7313466668, blue: 0.7748305202, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension EditProfileVC: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if let image = image {
            self.profileImageView.image = image
            self.setPickerData(image: image)
        }
    }
    
}
