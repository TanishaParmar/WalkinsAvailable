//
//  EventDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import UIKit
import MapKit

class EventDetailVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var getDirectionBtn: UIButton!
    @IBOutlet weak var favUnFavBtn: UIButton!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var eventMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDirectionBtn(_ sender: UIButton) {
        
    }

}
