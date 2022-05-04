//
//  EventVC.swift
//  WalkinsAvailable
//
//  Created by apple on 02/05/22.
//

import UIKit

class EventVC: UIViewController {

// MARK: OUTLETS
    
    @IBOutlet weak var ongoingBtn: UIButton!
    @IBOutlet weak var pastBtn: UIButton!
    @IBOutlet weak var myCreateBtn: UIButton!
    @IBOutlet weak var ongoingLbl: UILabel!
    @IBOutlet weak var pastLbl: UILabel!
    @IBOutlet weak var myCreateLbl: UILabel!
    @IBOutlet weak var eventListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

//    MARK: BUTTON ACTIONS
    
    @IBAction func ongoingBtn(_ sender: UIButton) {
       onGoingUpdate()
    }
    @IBAction func onCreateBtn(_ sender: UIButton) {
        let controller = EventCreateVC()
        self.push(viewController: controller)
    }
    
    @IBAction func pastBtn(_ sender: UIButton) {
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func myCreateBtn(_ sender: UIButton) {
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }
    
    func configureUI() {
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
        let nib = UINib(nibName: "EventListCell", bundle: nil)
        eventListTableView.register(nib, forCellReuseIdentifier: "EventListCell")
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
//    MARK: FUNCTIONS
    
    func onGoingUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func pastUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func myCreateUpdate(){
        ongoingLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pastLbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myCreateLbl.layer.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7278997302, blue: 0.7423141599, alpha: 1)
    }
    
}
extension EventVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! EventListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EventDetailVC()
        self.push(viewController: controller)

        
    }
    
    
}
