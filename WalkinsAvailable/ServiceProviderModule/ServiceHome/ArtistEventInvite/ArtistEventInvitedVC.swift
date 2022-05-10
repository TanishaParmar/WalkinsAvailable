//
//  ArtistEventInvitedVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ArtistEventInvitedVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var eventInvitedlisttableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventInvitedlisttableView.delegate = self
        eventInvitedlisttableView.dataSource = self
        let nib = UINib(nibName: "EventInviteListCell", bundle: nil)
        eventInvitedlisttableView.register(nib, forCellReuseIdentifier: "EventInviteListCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension ArtistEventInvitedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventInviteListCell", for: indexPath) as! EventInviteListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    
    
}
