//
//  EventCreateVC.swift
//  WalkinsAvailable
//
//  Created by apple on 04/05/22.
//

import UIKit
import IQKeyboardManagerSwift

class EventCreateVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var eventUploadImgView: UIImageView!
    @IBOutlet weak var uploadImgViewBtn: UIButton!
    @IBOutlet weak var eventNameTF: UITextField!
    @IBOutlet weak var eventNameView: UIView!
    @IBOutlet weak var starttimeView: UIView!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var startTimeTF: UITextField!
    @IBOutlet weak var endTimeTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: FUNCTIONS
    func configureUI(){
        eventNameView.layer.borderWidth = 1
        eventNameView.layer.borderColor = UIColor.black.cgColor
        starttimeView.layer.borderWidth = 1
        starttimeView.layer.borderColor = UIColor.black.cgColor
        endTimeView.layer.borderWidth = 1
        endTimeView.layer.borderColor = UIColor.black.cgColor
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.black.cgColor
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.black.cgColor
        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func uploadImgViewBtn(_ sender: UIButton) {
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
