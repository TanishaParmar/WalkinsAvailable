//
//  MapController.swift
//  CarCharger
//
//  Created by hitesh on 01/02/21.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var locationSearchBar: LocationSearchBar!
    @IBOutlet weak var mapView: SGMapView!
    @IBOutlet weak var locationSearchTable: LocationSearchTable!
    @IBOutlet weak var stackView: UIStackView!
    
    var chargers: [ChargerData] = []

    init() {
        super.init(nibName: "MapController", bundle: nil)
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLayoutSubviews() {
        self.setMapViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.setPinLocations(locations: [])
        self.setSearchAction()
        self.setTableView()
        self.mapView.sgDelegate = self
        self.stackView.layer.cornerRadius = 12
        
        self.stackView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let coordinate = LocationManager.shared.currentLocation?.coordinate else { return }
        self.mapView.setRegion(lat: coordinate.latitude, lng: coordinate.longitude, zoom: 500, animated: true)
        
    }
    
    func setMapViewController() {
        
        setMapView()
    }
    
    func setTableView() {
        let height = self.locationSearchTable.frame.height
        self.locationSearchTable.transform = .init(scaleX: 0, y: height)
        self.locationSearchTable.backgroundColor = .clear
        self.locationSearchTable.delegate = self
    }
    
    func setSearchAction() {
        locationSearchBar.interval = 0.35
        locationSearchBar.returnKeyType = .default
        locationSearchBar.layer.cornerRadius = 20
        locationSearchBar.placeholder = "Search location"
        locationSearchBar.setSearchBarBackground(color: .white)
        locationSearchBar.barTintColor = UIColor.blue
        locationSearchBar.tintColor = UIColor.blue
        locationSearchBar.setActions {
            DispatchQueue.main.async {
                self.setTableData(places: [])
            }
        } searchResults: { (items) in
            DispatchQueue.main.async {
                self.setTableData(places: items)
            }
        } isSearching: { (isSearching) in
            DispatchQueue.main.async {
                if isSearching {
                    let view = AnimatingView(height: 60, align: .center)
                    view.backgroundColor = .white
                    self.locationSearchTable.tableHeaderView = view
                } else {
                    self.locationSearchTable.tableHeaderView = nil
                }
            }
        } searchButtonClicked: {
            self.view.endEditing(true)
            let height = self.locationSearchTable.frame.height
            UIView.animate(withDuration: 0.25) {
                self.locationSearchTable.transform = .init(scaleX: 0, y: height)
            }
        } searchBeginEditing: {
            UIView.animate(withDuration: 0.25) {
                self.locationSearchTable.transform = .identity
            }
        } searchEndEditing: {
            let height = self.locationSearchTable.frame.height
            UIView.animate(withDuration: 0.25) {
                self.locationSearchTable.transform = .init(scaleX: 0, y: height)
            }
        }
    }
    
    func setTableData(places: [Location]) {
        self.locationSearchTable.setPlaces(places: places)
    }
    
    private func setMapView() {
//        let locations = chargers?.map({FBAnnotation(charger: $0)}) ?? []
        let array:[(Double, Double)] = [
            (30.7333, 76.7794),
            (30.7300, 76.7700),
            (30.7400, 76.7600),
            (30.7500, 76.7650),
            (40.9006, 174.8860),
            (-36.848461,174.763336),
            (-38.685692,176.070206),
            (-41.209164,174.908051),
            (-37.683334,176.166672),
            (30.70986938,76.69013925)
        ]
        let locations = array.map({FBAnnotation(value: $0)})
        
        self.mapView.setPinLocations(locations: locations)
        self.mapView.setNeedsLayout()
        self.mapView.layoutIfNeeded()
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        
    }
    
    @IBAction func zoomCurrentLocationAction(_ sender: UIButton) {
        let location = self.mapView.userLocation.coordinate
        self.mapView.setRegion(location: location, zoom: 6000, animated: true)
    }
    
}


extension MapController: SGMapViewDelegate {
    func didSelect(card: FBAnnotation) {
        print("didselect \(card.charger)")
        let controller = LocationDetailVC()
        controller.parentVC = self
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    func didTapNavigation(card: FBAnnotation) {
        
        let data = card.charger
        
        let from = self.mapView.userLocation.coordinate
        let lat = card.coordinate.latitude
        let lng = card.coordinate.longitude
        var urlStr = "http://maps.apple.com/maps"
        urlStr    += "?saddr=\(from.latitude),\(from.longitude)"
        urlStr    += "&daddr=\(lat),\(lng)"
        guard let url = URL(string: urlStr) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

extension MapController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinate = locationSearchTable.places[indexPath.row].placemark.location?.coordinate
        self.locationSearchBar.endEditing(true)
        let height = self.locationSearchTable.frame.height
        self.locationSearchTable.transform = .init(scaleX: 0, y: height)
        print("placemark =========> \(coordinate)")
        self.mapView.setRegion(lat: coordinate?.latitude ?? 0 , lng: coordinate?.longitude ?? 0, zoom: 5000, animated: true)
    }
    
}
