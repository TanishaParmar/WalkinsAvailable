//
//  AboutUsVC.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//

import UIKit

class AboutUsVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
