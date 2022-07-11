//
//  AddArtistListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

protocol AddArtistListCellDelegate {
    func addArtist(data: SearchArtistData?, sender: UIButton)
}


class AddArtistListCell: UITableViewCell {

    @IBOutlet weak var artistImgCell: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    
    var searchArtistData: SearchArtistData?
    var delegate: AddArtistListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImgCell.layer.cornerRadius = artistImgCell.frame.height/2
        artistImgCell.clipsToBounds = true
        addBtn.layer.cornerRadius = 4
        addBtn.clipsToBounds = true
    }
    
    func setUI(searchArtistData: SearchArtistData, delegate: AddArtistListCellDelegate?) {
        self.searchArtistData = searchArtistData
        self.delegate = delegate
        
        self.nameLbl.text = searchArtistData.ownerName
        switch searchArtistData.isJoin {
        case "0": self.addBtn.setTitle("Add", for: .normal)
        case "1": self.addBtn.setTitle("Added", for: .normal)
        default:  self.addBtn.setTitle("Requested", for: .normal)
        }
        let placeHolder = UIImage(named: "placeHolder")
        self.artistImgCell.setImage(url: searchArtistData.image, placeHolder: placeHolder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addArtistButtonAction(_ sender: UIButton) {
        guard searchArtistData?.isJoin == "0" else { return }
        self.delegate?.addArtist(data: self.searchArtistData, sender: sender)
    }
    
    
}
