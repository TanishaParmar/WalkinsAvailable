//
//  SetAvailbilityVC.swift
//  WalkinsAvailable
//
//  Created by apple on 03/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class SetAvailbilityVC: UIViewController,UITextFieldDelegate {

    var isNav:Bool?
    
//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var startTimeView: UIView!
    @IBOutlet weak var startTimeTF: UITextField!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeTF: UITextField!
    @IBOutlet weak var waitingView: UIView!
    @IBOutlet weak var waitingTimeTF: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if isNav == true{
            self.headerLbl.text = "Edit Set Availability"
        }else{
            self.headerLbl.text = "Set Availbilty"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    MARK: Actions
    @IBAction func btnSaveAction(_ sender: UIButton) {
        let controller = AvailbilityVC()
        self.push(viewController: controller)
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    MARK: CONFIGURE UI
    func configureUI(){
        self.dayTF.delegate = self
        self.startTimeTF.delegate = self
        self.endTimeTF.delegate = self
        self.waitingTimeTF.delegate = self
        self.dayView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.dayView.layer.borderWidth = 1
        self.startTimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.startTimeView.layer.borderWidth = 1
        self.endTimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.endTimeView.layer.borderWidth = 1
        self.waitingView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.waitingView.layer.borderWidth = 1
        
    }
    //    MARK: TEXTFIELD DELEGATES
        func textFieldDidBeginEditing(_ textField: UITextField) {
            dayView.layer.borderColor = textField == dayTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            startTimeView.layer.borderColor = textField == startTimeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            endTimeView.layer.borderColor = textField == endTimeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            waitingView.layer.borderColor = textField == waitingTimeTF ?  #colorLiteral(red: 0.9816202521, green: 0.7352927327, blue: 0.7788162231, alpha: 1)  :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            dayView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            startTimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            endTimeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            waitingView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
