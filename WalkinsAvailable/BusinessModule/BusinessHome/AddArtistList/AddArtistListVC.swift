//
//  AddArtistListVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class AddArtistListVC: UIViewController {

//    MARK: OUTLETS
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addArtistSearchBar: UISearchBar!
    @IBOutlet weak var addArtistListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addArtistListTableView.delegate = self
        self.addArtistListTableView.dataSource = self
        let nib = UINib(nibName: "AddArtistListCell", bundle: nil)
        self.addArtistListTableView.register(nib, forCellReuseIdentifier: "AddArtistListCell")
    }

}
extension AddArtistListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddArtistListCell", for: indexPath) as! AddArtistListCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
