//
//  SignUpServiceVC.swift
//  WalkinsAvailable
//
//  Created by apple on 10/05/22.
//

import UIKit

class SignUpServiceVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userNameImgView: UIImageView!
    @IBOutlet weak var editProfileImgVw: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var artistView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistView.layer.borderWidth = 1
        artistView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.borderWidth = 1
        emailView.layer.borderColor = UIColor.black.cgColor
        passwordView.layer.borderWidth = 1
        passwordView .layer.borderColor = UIColor.black.cgColor
    
    }
    @IBAction func editBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func editProfileImgViewBtn(_ sender: UIButton) {
        
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        Singleton.setHomeScreenView(userType: .serviceProvider)
    }
    
}
