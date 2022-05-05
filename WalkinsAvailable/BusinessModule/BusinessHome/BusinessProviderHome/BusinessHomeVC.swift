//
//  BusinessHomeVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class BusinessHomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setTableHeader()
    }


    func setTableHeader() {
        let nibName = UINib(nibName: "BusinessHomeHeaderView", bundle: nil)
        self.tableView.register(nibName, forHeaderFooterViewReuseIdentifier: "BusinessHomeHeaderView")
    }
    
    
}
