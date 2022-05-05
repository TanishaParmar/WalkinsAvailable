//
//  ContactUsVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//


import UIKit
import IQKeyboardManagerSwift

class ContactUsVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
//        userNameTextField.delegate = self
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
        self.nameView.addCornerBorderAndShadow(view: self.nameView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.emailView.addCornerBorderAndShadow(view: self.emailView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.messageView.addCornerBorderAndShadow(view: self.messageView, cornerRadius: 5.0, shadowColor: .clear, borderColor: .black, borderWidth: 1.0)
        self.saveButton.addCornerRadius(view: self.saveButton, cornerRadius: 5.0)
    }
    
    
    
    //MARK: Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    
}

