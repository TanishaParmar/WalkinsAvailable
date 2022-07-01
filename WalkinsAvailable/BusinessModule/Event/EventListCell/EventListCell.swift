//
//  EventListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import UIKit

class EventListCell: UITableViewCell {

//    MARK: OUTLETS
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var eventData: EventsList?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCell.layer.cornerRadius = 4
        imgCell.clipsToBounds = true
    }
    
    func setUIElements(eventData: EventsList) {
        self.eventData = eventData
        nameLbl.text = self.eventData?.eventName
        descriptionLbl.text = self.eventData?.description
        let placeHolder = UIImage(named: "placeHolder")
        self.imgCell.setImage(url: self.eventData?.image, placeHolder: placeHolder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
