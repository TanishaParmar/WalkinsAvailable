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
        emailView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.borderWidth = 1
        artistView.layer.borderColor = UIColor.black.cgColor
        artistView.layer.borderWidth = 1
        emailView.layer.cornerRadius = 4
        artistView.layer.cornerRadius = 4
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        saveBtn.layer.cornerRadius = 4
        saveBtn.clipsToBounds = true
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileImgVw(_ sender: UIButton) {
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
    }
    

}
