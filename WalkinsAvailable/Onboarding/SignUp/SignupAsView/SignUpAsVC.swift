//
//  SignUpAsVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/2/22.
//


import UIKit

class SignUpAsVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var signUpAsUserButton: UIButton!
    @IBOutlet weak var signUpAsBusinessButton: UIButton!
    @IBOutlet weak var signUpAsServiceProviderButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Methods
    
    
    
    //MARK: Actions
    @IBAction func signUpAsUserButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsUserVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpAsBusinessButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsBusinessVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpAsServiceProviderButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsBusinessVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        let viewcontroller = LoginVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
}

