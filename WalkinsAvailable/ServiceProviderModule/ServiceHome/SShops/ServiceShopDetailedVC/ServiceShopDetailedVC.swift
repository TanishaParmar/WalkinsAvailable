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
    @IBOutlet weak var deleteBusinessButton: UIButton!
    @IBOutlet weak var manuallyButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var setAvailabilitySwitch: UISwitch!
    
    var associatedBusinessData: SearchBusinessData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteBusinessButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func manuallyButtonAction(_ sender: Any) {
        manuallyButton.isSelected = true
        weeklyButton.isSelected = false
    }
    
    @IBAction func weeklyButtonAction(_ sender: Any) {
        manuallyButton.isSelected = false
        weeklyButton.isSelected = true
    }
    


}
