//
//  ChatListVC.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/5/22.
//

import UIKit
import IQKeyboardManagerSwift

class ChatListVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var chatListingTableView: UITableView!
    
    
    //MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
        chatListingTableView.dataSource = self
        chatListingTableView.delegate = self
        let nib = UINib(nibName: "ChatListTVC", bundle: nil)
        chatListingTableView.register(nib, forCellReuseIdentifier: "ChatListTVC")
    }
    
    //MARK: Actions

}

extension ChatListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTVC", for: indexPath) as! ChatListTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = SingleChatController()
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
