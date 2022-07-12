//
//  DeleteArtistPopUpVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/12/22.
//

import UIKit
protocol DeleteArtistPopUpVCDelegate: NSObjectProtocol {
    func dismissView()
}

class DeleteArtistPopUpVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var artistDetail: ArtistDetail = ArtistDetail()
    var delegate: DeleteArtistPopUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }


    func setUI() {
        self.contentView.addCornerRadius(view: self.contentView, cornerRadius: 10.0)
        self.yesView.addCornerRadius(view: self.yesView, cornerRadius: 10.0)
        self.noView.addCornerRadius(view: self.noView, cornerRadius: 10.0)
        self.nameLabel.text = "Do you want to remove\n\(self.artistDetail.ownerName ?? "") ?"
    }
    
    //MARK: hit Remove Artist Api
    func hitRemoveArtistApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        //MARK: Hit Business Home API
        ApiHandler.updateProfile(apiName: API.Name.addArtist, params: ["isRemove": "1", "artistId": self.artistDetail.artistId ?? ""]) { succeeded, response, dataRes in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                self.delegate?.dismissView()
                self.dismiss(animated: true, completion: nil)
//                data?.isJoin = "Requested"
//                sender.setTitle("Requested", for: .normal)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    
    @IBAction func cancelButtonACtion(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonAction(_ sender: Any) {
        hitRemoveArtistApi()
    }
    
    @IBAction func noButtonAction(_ sender: Any) {
        self.delegate?.dismissView()
        self.dismiss(animated: true, completion: nil)
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
