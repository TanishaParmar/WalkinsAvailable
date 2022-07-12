//
//  ArtistListingVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/12/22.
//

import UIKit

class ArtistListingVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var artistData: [ArtistData]?

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let nib = UINib(nibName: "AddArtistListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AddArtistListCell")
        self.tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 50, right: 0)
    }


    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//    MARK: UITableView Delegate & DataSource
extension ArtistListingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddArtistListCell", for: indexPath) as! AddArtistListCell
        cell.setArtistData(artistData: self.artistData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ArtistDetailedVC()
        controller.artistId = self.artistData?[indexPath.row].artistId
        self.push(viewController: controller)

    }
        
}
