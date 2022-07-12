//
//  BusinessHomeFooterView.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/8/22.
//

import UIKit

class BusinessHomeFooterView: UIView {
    
    
    @IBOutlet weak var seeAllButton: UIButton!
    
    
    var artistData: [ArtistData]?

   
    func updateUIElements(artistData: [ArtistData]?) {
        self.artistData = artistData
    }
    

    @IBAction func seeAllButtonAction(_ sender: Any) {
        let controller = ArtistListingVC()
        controller.artistData = self.artistData
        if let topVC = UIApplication.getTopViewController() {
            topVC.push(viewController: controller)
        }
    }
}
