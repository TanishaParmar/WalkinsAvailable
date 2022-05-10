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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.borderWidth = 1
        artistView.layer.borderColor = UIColor.black.cgColor
        artistView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editProfileImgVw(_ sender: UIButton) {
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
    }
    

}
