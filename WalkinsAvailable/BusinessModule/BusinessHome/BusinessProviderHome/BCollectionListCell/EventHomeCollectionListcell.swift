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
    
    var eventsData: InviteEventDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.eventView.addCornerBorderAndShadow(view: self.eventView, cornerRadius: 4, shadowColor: .lightGray, borderColor: .lightGray, borderWidth:  1.0)
    }
    
    
    func setUI(eventsData: InviteEventDetail?) {
        self.eventsData = eventsData
        if let eventsData = eventsData?.eventDetail {
            self.eventname.text = eventsData.eventName
            self.descriptionLbl.text = eventsData.description
            let placeHolder = UIImage(named: "eventPlaceHolder")
            self.imgCell.setImage(url: eventsData.image, placeHolder: placeHolder)

        }
    }
    

}
