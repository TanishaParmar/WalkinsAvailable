//
//  LocationSearchTable.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//
import UIKit

class LocationSearchTable: UITableView {

    var places: [Location] = []
//    private var didSelect: ((Location)->())?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setTableView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTableView()
    }
    
    func setTableView() {
//        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "c")
    }
    
    func setPlaces(places: [Location]) {
        self.places = places
        self.reloadData()
    }

}

extension LocationSearchTable : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath)
        // as! LocationSearchTableCell
        cell.textLabel?.text = self.places[indexPath.row].address
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        DispatchQueue.main.async {
//            print("location is \(self.places[indexPath.row].placemark.location?.coordinate.latitude)")
//            self.didSelect?(self.places[indexPath.row])
//        }
//    }
    
}
