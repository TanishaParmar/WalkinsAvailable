//
//  BusinessHomeListCell.swift
//  WalkinsAvailable
//
//  Created by apple on 06/05/22.
//

import UIKit

class BusinessHomeListCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    var eventsData: [InviteEventDetail]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        let nib = UINib(nibName: "EventHomeCollectionListcell", bundle: nil)
        eventCollectionView.register(nib, forCellWithReuseIdentifier: "EventHomeCollectionListcell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUIElements(eventsData: [InviteEventDetail]?) {
        self.eventsData = eventsData
        self.eventCollectionView.reloadData()
    }
    
}
extension BusinessHomeListCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let padding: CGFloat =  collectionImgView.frame.size.width
        let collectionViewSize = (eventCollectionView.frame.size.width / 1.7) - 2
      return CGSize(width: collectionViewSize, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventHomeCollectionListcell", for: indexPath) as! EventHomeCollectionListcell
        cell.setUI(eventsData: self.eventsData?[indexPath.row])
        return cell
    }
}
