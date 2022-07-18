//
//  ServiceShopDetailedVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/14/22.
//

import UIKit

class ServiceShopDetailedVC: UIViewController {
    
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessDescriptionLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonView: UIView!
    @IBOutlet weak var deleteBusinessButton: UIButton!
    @IBOutlet weak var manuallyButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var setAvailabilitySwitch: UISwitch!
    
    var associatedBusinessData: SearchBusinessData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     setUI()
    }
    
    func setUI() {
        self.businessNameLabel.text = self.associatedBusinessData?.businessName
        self.businessDescriptionLabel.text = self.associatedBusinessData?.businessDescription
        let placeHolder = UIImage(named: "placeHolder")
        self.businessImageView.setImage(url: self.associatedBusinessData?.image, placeHolder: placeHolder)

    }
    
    func removeBusiness() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        //MARK: Hit Business Home API
        ApiHandler.updateProfile(apiName: API.Name.businessRequest, params: ["isRemove": "1", "businessId": self.associatedBusinessData?.businessId ?? ""]) { succeeded, response, dataRes in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
//                deleteBusinessButton?.isJoin = "Requested"
//                deleteBusinessButton.setTitle("Requested", for: .normal)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteBusinessButtonAction(_ sender: Any) {
        
//        if let topVC = UIApplication.getTopViewController() {
            self.popActionAlert(title: AppAlertTitle.appName.rawValue, message: AppAlertMessage.deleteBusinessShop, actionTitle: ["Yes","No"], actionStyle: [.default, .cancel], action: [{ ok in
                self.removeBusiness()
            },{
                cancel in
                self.dismiss(animated: false, completion: nil)
            }])
            
//        }
        
    }
    
    @IBAction func manuallyButtonAction(_ sender: Any) {
        manuallyButton.isSelected = true
        weeklyButton.isSelected = false
    }
    
    @IBAction func weeklyButtonAction(_ sender: Any) {
        manuallyButton.isSelected = false
        weeklyButton.isSelected = true
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
    }
    


}
