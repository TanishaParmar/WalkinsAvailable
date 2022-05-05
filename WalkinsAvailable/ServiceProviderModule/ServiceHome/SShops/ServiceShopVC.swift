//
//  ServiceShopVC.swift
//  WalkinsAvailable
//
//  Created by apple on 05/05/22.
//

import UIKit

class ServiceShopVC: UIViewController {

    @IBOutlet weak var shopListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: Methods
    func configureUI() {
        shopListTableView.dataSource = self
        shopListTableView.delegate = self
        shopListTableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "ShopsListCell", bundle: nil)
        shopListTableView.register(nib, forCellReuseIdentifier: "ShopsListCell")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ServiceShopVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopsListCell", for: indexPath) as! ShopsListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    
}
