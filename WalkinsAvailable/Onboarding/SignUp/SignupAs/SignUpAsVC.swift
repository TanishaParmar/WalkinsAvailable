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
    @IBOutlet weak var signUpuserView: UIView!
    @IBOutlet weak var signUpAsBusinessButton: UIButton!
    @IBOutlet weak var signUpAsServiceProviderButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpAsBusinessView: UIView!
    @IBOutlet weak var signUpAsServiceProviderView: UIView!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Methods
    func configureUI(){
        signUpuserView.layer.cornerRadius = 4
        signUpAsBusinessView.layer.cornerRadius = 4
        signUpAsServiceProviderView.layer.cornerRadius = 4
        self.navigationController?.navigationBar.isHidden = true

    }
    
    
    //MARK: Actions
    @IBAction func signUpAsUserButtonAction(_ sender: Any) {
        let viewcontroller = SignUpAsUserVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpAsBusinessButtonAction(_ sender: Any) {
        let viewcontroller = SignUpBusinessProfile()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func signUpAsServiceProviderButtonAction(_ sender: Any) {
        let viewcontroller = SignUpServiceVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        let viewcontroller = LoginVC()
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
}

