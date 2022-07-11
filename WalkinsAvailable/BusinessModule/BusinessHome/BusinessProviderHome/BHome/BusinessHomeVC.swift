//
//  BusinessHomeVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class BusinessHomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businessHomeData: BusinessHomeData = BusinessHomeData()

    var listArr:[String] = ["Invite Events","Nearby Events"]
    var artistCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        hitBusinessHomeApi()
    }
    
    func registerCell() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "BusinessHomeListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BusinessHomeListCell")
        let nib1 = UINib(nibName: "BusinessArtistTotalListCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "BusinessArtistTotalListCell")
        DispatchQueue.main.async {
            let headerView  = UINib(nibName: "BusinessHomerHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as? BusinessHomerHeaderView
            headerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)//350
            self.tableView.tableHeaderView = headerView
        }
    }
    
    //MARK: Hit Business Home API
    func hitBusinessHomeApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.businessHomeDetail, params: [:]) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: BusinessDataResponseModel.self) {
                        if let data = response.data {
                            print(data)
                            self.businessHomeData = data
                            
                            print("****************123", data.inviteEventDetail)
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
    }
    
}



extension BusinessHomeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.businessHomeData.artistsList?.count ?? 0
        case 1:
            return self.businessHomeData.inviteEventDetail?.count ?? 0 > 0 ? 1 : 0
        case 2:
            return self.businessHomeData.nearByEvent?.count ?? 0 > 0 ? 1 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessArtistTotalListCell", for: indexPath) as! BusinessArtistTotalListCell
            let artistData = self.businessHomeData.artistsList?[indexPath.row]
            cell.updateUIElements(artistData: artistData)
            return cell
        case 1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessHomeListCell", for: indexPath) as! BusinessHomeListCell
            let eventsData = self.businessHomeData.inviteEventDetail
            cell.setUIElements(eventsData: eventsData)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = (Bundle.main.loadNibNamed("BusinessHomeHeaderView", owner: self, options: nil)![0] as? BusinessHomeHeaderView)
        switch section {
        case 0:
            view?.seeAllButton.isHidden = true
            view?.seeAllButton.isUserInteractionEnabled = false
            view?.addButton.isHidden = false
            view?.addButton.isUserInteractionEnabled = true
            view?.lineLabel.isHidden = false
            view?.headerLabel.text = "Service Provider"
            return view
        case 1,2:
            view?.lineLabel.isHidden = true
            view?.seeAllButton.isHidden = false
            view?.seeAllButton.isUserInteractionEnabled = true
            view?.addButton.isHidden = true
            view?.addButton.isUserInteractionEnabled = false
            view?.headerLabel.text = section == 1 ? "Invite Event" : "Near by events"
            return view
        default:
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = (Bundle.main.loadNibNamed("BusinessHomeFooterView", owner: self, options: nil)![0] as? BusinessHomeFooterView)

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (self.businessHomeData.artistsList?.count ?? 0 > 4 && section == 0) ? 50 : 0
    }
    
    @objc func btnSeeAllAction(sender : UIButton) {
        let controller = BusinessEventVC()
        self.push(viewController: controller)
    }
    
//    @objc func buttonAction(sender : UIButton) {
//        let controller = BusinessEditProfile()
//        self.push(viewController: controller)
//    }
    
}



//extension BusinessHomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewSize = (collectionView.frame.size.width / 5) - 2
//        return CGSize(width: collectionViewSize, height: collectionViewSize + 20)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessArtistListCell", for: indexPath) as! BusinessArtistListCell
//        if indexPath.row == 0 {
//            cell.imageView.image = UIImage(named: "add-1")
//            cell.nameLbl.isHidden = false
//            cell.nameHeightConstraionts.constant = 15
//            cell.imageSuperView.layer.borderColor = UIColor.clear.cgColor
//            cell.imageSuperView.layer.borderWidth = 0
//        } else {
//            cell.nameLbl.isHidden = true
//            if indexPath.row % 2 == 0 {
//                cell.imageSuperView.layer.borderColor = UIColor.green.cgColor
//                cell.imageSuperView.layer.borderWidth = 1
//            } else {
//                cell.imageSuperView.layer.borderColor = UIColor.red.cgColor
//                cell.imageSuperView.layer.borderWidth = 1
//            }
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//          let vc = AddArtistListVC()
//            self.push(viewController: vc)
//        }else{
//        }
//    }
//}
