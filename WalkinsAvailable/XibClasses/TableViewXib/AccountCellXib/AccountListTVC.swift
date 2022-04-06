//
//  AccountListTVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/6/22.
//

import UIKit

class AccountListTVC: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchIcon: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
        iconImageView.addCornerRadius(view: iconImageView, cornerRadius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
