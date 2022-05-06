//
//  EventHomeCollectionListcell.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class EventHomeCollectionListcell: UICollectionViewCell {
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var eventname: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var eventView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.eventView.layer.borderColor = UIColor.gray.cgColor
//        self.eventView.layer.borderWidth = 1
//        self.eventView.layer.cornerRadius = 4
//        self.eventView.layer.shadowColor = UIColor.gray.cgColor
//        self.eventView.layer.shadowOpacity = 0.3
//        self.eventView.layer.shadowOffset = CGSize.zero
//        self.eventView.layer.shadowRadius = 6
        self.eventView.addCornerBorderAndShadow(view: self.eventView, cornerRadius: 4, shadowColor: .lightGray, borderColor: .lightGray, borderWidth:  1.0)
    }

}
