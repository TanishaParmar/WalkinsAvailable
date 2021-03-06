//
//  EventDetailVC.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import UIKit
import MapKit

class EventDetailVC: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var getDirectionBtn: UIButton!
    @IBOutlet weak var favUnFavBtn: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptRejectSuperView: UIView!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var eventMapView: MKMapView!
    @IBOutlet weak var acceptRejectSuperViewHeight: NSLayoutConstraint!
    
    var eventId: String?
    var eventDetail: EventDetail?
    var isFromEventList: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hitEventDetailApi()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureUI() {
        self.acceptView.addCornerRadius(view: self.acceptView, cornerRadius: 10.0)
        self.rejectView.addCornerRadius(view: self.rejectView, cornerRadius: 10.0)
    }
    
    func setUIElements() {
        self.eventNameLabel.text = self.eventDetail?.eventName
        self.detailLbl.text = self.eventDetail?.description
        self.locationLbl.text = self.eventDetail?.eventLocation
        self.dateTimeLbl.text = "\(self.eventDetail?.eventDate ?? ""), \(self.eventDetail?.startTime ?? "") - \(self.eventDetail?.endTime ?? "")"
        self.favUnFavBtn.isSelected = self.eventDetail?.isFav == "1" 
        let placeHolder = UIImage(named: "eventPlaceHolder")
        self.eventImageView.setImage(url: self.eventDetail?.image, placeHolder: placeHolder)
        if isFromEventList {
            acceptRejectSuperView.isHidden = true
            acceptRejectSuperViewHeight.constant = 0
        }
    }
    
    //MARK: Hit Event Detail API
    func hitEventDetailApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.eventDetails, params: ["eventId": eventId ?? ""]) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: EventDetailModel.self) {
                    if let data = response.data {
                        self.eventDetail = data
                        self.setUIElements()
//                        self.eventListTableView.reloadData()
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    //MARK: Hit Fav Unfav API
    func hitFavUnFavApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.favUnfavEvent, params: generatingFavnFavParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: FavUnFavModel.self) {
                    if let isFav = response.isFav {
                        self.favUnFavBtn.isSelected = isFav == "1"
                    }
                }
                print(response)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    func generatingFavnFavParameters() -> [String:Any] {
        var params : [String:Any] = [:]
        params["eventId"] = self.eventDetail?.eventId
        params["role"] = "2"
        print(params)
        return params
    }
    
    
    @IBAction func favUnFavButtonAction(_ sender: Any) {
        hitFavUnFavApi()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDirectionBtn(_ sender: UIButton) {
        let current = LocationManager.shared.currentLocation?.coordinate
        let source = "saddr=\(current?.latitude ?? 0.0),\(current?.longitude ?? 0.0)&"
        let destination = "daddr=\(self.eventDetail?.latitude ?? ""),\(self.eventDetail?.longitude ?? "")"
//        let destination = "daddr=\(30.7421),\(76.8188)"
        if let path = URL(string: "maps://?\(source)\(destination)") {
            print(path)
            UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func acceptButtonAction(_ sender: Any) {
    }
    
    @IBAction func rejectButtonACtion(_ sender: Any) {
    }
    
}
