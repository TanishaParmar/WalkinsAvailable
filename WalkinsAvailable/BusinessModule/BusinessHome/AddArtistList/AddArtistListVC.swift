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
    
    var timer: Timer?
    var searchArtistData: [SearchArtistData] = [SearchArtistData]()
    var pageNo:Int = 0
    var isDataCompleted: Bool = false
    var isFetchingData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addArtistListTableView.delegate = self
        self.addArtistListTableView.dataSource = self
        addArtistSearchBar.delegate = self
        addArtistListTableView.keyboardDismissMode = .onDrag
        let nib = UINib(nibName: "AddArtistListCell", bundle: nil)
        self.addArtistListTableView.register(nib, forCellReuseIdentifier: "AddArtistListCell")
        self.addArtistListTableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 50, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hitSearchArtistApi(searchText: "")
    }
    
    //MARK: Hit Search Artist API
    func hitSearchArtistApi(searchText: String) {
        guard self.isDataCompleted == false else { return }
        guard self.isFetchingData == false else { return }
        self.isFetchingData = true
        let params:[String: Any] = [
            "search": searchText,
            "perPage": "20",
            "pageNo": "\(self.pageNo+1)"
        ]
        
        ApiHandler.updateProfile(apiName: API.Name.artistBySearch, params: params) { succeeded, response, data in
            print("response data ** \(response)")
            self.isFetchingData = false
            if succeeded {
                if let response = DataDecoder.decodeData(data, type: SearchArtistResponse.self) {
                    if let data = response.data {
                        if data.count > 0 {
                            self.isDataCompleted = data.count < 20
                            self.pageNo = self.pageNo + 1
                            self.searchArtistData.append(contentsOf: data)
                            self.addArtistListTableView.backgroundView = nil
                            self.addArtistListTableView.reloadData()
                            
                        } else {
                            if self.searchArtistData.count > 0 {
                                self.addArtistListTableView.backgroundView = nil
                            } else {
                                self.addArtistListTableView.setBackgroundView(message: "No Service Provider found.")
                            }
                            self.isDataCompleted = true
                            self.addArtistListTableView.reloadData()
                        }
                    }
                }
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//    MARK: UITableView Delegate & DataSource
extension AddArtistListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArtistData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddArtistListCell", for: indexPath) as! AddArtistListCell
        cell.setUI(searchArtistData: self.searchArtistData[indexPath.row], delegate: self)
        return cell
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (self.searchArtistData.count-1) == indexPath.row else { return }
        self.hitSearchArtistApi(searchText: self.addArtistSearchBar.text ?? "")
    }
    
}

//MARK: AddArtistListCellDelegate
extension AddArtistListVC: AddArtistListCellDelegate {
    func addArtist(data: SearchArtistData?, sender: UIButton) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        //MARK: Hit Business Home API
        ApiHandler.updateProfile(apiName: API.Name.addArtist, params: ["artistId": data?.artistId ?? ""]) { succeeded, response, dataRes in
            print("response data ** \(response)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            if succeeded {
                data?.isJoin = "Requested"
                sender.setTitle("Requested", for: .normal)
            } else {
                if let msg = response["message"] as? String {
                    Singleton.shared.showErrorMessage(error: msg, isError: .error)
                }
            }
        }
    }
}

extension AddArtistListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
            if self.searchArtistData.count > 0 {
                self.searchArtistData.removeAll()
                self.addArtistListTableView.reloadData()
            }
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchText(_:)), userInfo: searchText, repeats: false)
    }
    
    @objc func searchText(_ timer: Timer) {
        guard let searchKey = timer.userInfo as? String else { return }
        self.pageNo = 0
        self.isDataCompleted = false
        self.isFetchingData = false
        self.hitSearchArtistApi(searchText: searchKey)
    }
    
}
