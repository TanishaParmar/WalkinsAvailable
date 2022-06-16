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
        emailView.addCornerBorderAndShadow(view: emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        artistView.addCornerBorderAndShadow(view: artistView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        descriptionTextView.addCornerBorderAndShadow(view: descriptionTextView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1)
        saveBtn.addCornerRadius(view: saveBtn, cornerRadius: 5)
    }
    
    // MARK: VAILDATIONS
    func validate() {
        if ValidationManager.shared.isEmpty(text: artistNameTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterArtistName, isError: .error)
        }else  if ValidationManager.shared.isEmpty(text: emailTF.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterEmail, isError: .error)
        }else if emailTF.text!.isValidEmail == false {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.validEmail, isError: .error)
        }else if ValidationManager.shared.isEmpty(text: descriptionTextView.text) == true {
            Singleton.shared.showErrorMessage(error: AppAlertMessage.enterDescription, isError: .error)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileImgVw(_ sender: UIButton) {
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
