//
//  InviteFromShopVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class InviteFromShopVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var inviteSearchBar: UISearchBar!
    @IBOutlet weak var requestInvitetableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: Actions
    func configureUI() {
        requestInvitetableView.dataSource = self
        requestInvitetableView.delegate = self
        let nib = UINib(nibName: "RequestInviteFromCell", bundle: nil)
        requestInvitetableView.register(nib, forCellReuseIdentifier: "RequestInviteFromCell")
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension InviteFromShopVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestInviteFromCell", for: indexPath) as! RequestInviteFromCell
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    
}
