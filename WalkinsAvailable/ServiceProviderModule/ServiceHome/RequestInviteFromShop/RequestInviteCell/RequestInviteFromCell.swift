//
//  RequestInviteFromCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

protocol RequestInviteFromCellDelegate {
    func requestToBustiness(businessData: SearchBusinessData?, sender: UIButton)
}

import UIKit

class RequestInviteFromCell: UITableViewCell {

    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var businessData: SearchBusinessData?
    var delegate: RequestInviteFromCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
        configureUI()
    }
    
    func configureUI() {
        self.requestBtn.addCornerRadius(view: self.requestBtn, cornerRadius: 4.0)
        self.imgCell.addCornerRadius(view: self.imgCell, cornerRadius: imgCell.frame.size.width / 2)
    }
    
    func setUIElements(businessData: SearchBusinessData?, delegate: RequestInviteFromCellDelegate) {
        self.delegate = delegate
        self.businessData = businessData
        
        self.nameLbl.text = businessData?.businessName
        switch businessData?.isJoin {
        case "0": self.requestBtn.setTitle("Request", for: .normal)
        case "1": self.requestBtn.setTitle("Added", for: .normal)
        default:  self.requestBtn.setTitle("Requested", for: .normal)
        }
        let placeHolder = UIImage(named: "placeHolder")
        self.imgCell.setImage(url: businessData?.image, placeHolder: placeHolder)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func requestButtonAction(_ sender: UIButton) {
        guard businessData?.isJoin == "0" else { return }
        self.delegate?.requestToBustiness(businessData: self.businessData, sender: sender)
    }
    
    
}
