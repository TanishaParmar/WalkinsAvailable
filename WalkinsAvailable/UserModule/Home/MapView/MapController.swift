//
//  MapController.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/5/22.
//


import UIKit
import MapKit

class MapController: UIViewController {
    
    @IBOutlet weak var locationSearchBar: LocationSearchBar!
    @IBOutlet weak var mapView: SGMapView!
    @IBOutlet weak var locationSearchTable: LocationSearchTable!
    @IBOutlet weak var stackView: UIStackView!
    
    var mapData: [MapData] = []
    var businessEventResponse = BusinessEventByLocationResponseModel()
    var businessTypeId: String?
    
    init() {
        super.init(nibName: "MapController", bundle: nil)
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        hitBusinessEventListApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let coordinate = LocationManager.shared.currentLocation?.coordinate else { return }
        self.mapView.setRegion(lat: coordinate.latitude, lng: coordinate.longitude, zoom: 1500, animated: true)
    }
    
    
    func generatingArtistHomeParameters() -> [String:Any] {
        let currentLoc = LocationManager.shared.currentLocation?.coordinate
        var params : [String:Any] = [:]
        params["businessTypeId"] = businessTypeId ?? ""
        params["search"] = ""
        params["latitude"] = currentLoc?.latitude
        params["longitude"] = currentLoc?.longitude

        debugPrint("params data ** \(params)")
        return params
    }
    
    
    func hitBusinessEventListApi() {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.getBusinessAndEventByLocation, params: generatingArtistHomeParameters()) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: BusinessEventByLocationResponseModel.self) {
                        print(response.allEvents?.count)
                        print(response.allBusinesses?.count)
                        self.businessEventResponse = response
                        self.setMapView(businesses: response.allBusinesses ?? [], events: response.allEvents ?? [])
                    }
                } else {
                    if let msg = response["message"] as? String {
                        Singleton.shared.showErrorMessage(error: msg, isError: .error)
                    }
                }
            }
        }
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
    
    private func setMapView(businesses: [BusinessData], events: [EventDetail]) {
        var array = [Any]()
        array.append(contentsOf: businesses)
        array.append(contentsOf: events)
        
        let locations = array.map({FBAnnotation(data: $0)})
        
        self.mapView.setPinLocations(locations: locations)
        self.mapView.setNeedsLayout()
        self.mapView.layoutIfNeeded()
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        
    }
    
    @IBAction func zoomCurrentLocationAction(_ sender: UIButton) {
        let location = self.mapView.userLocation.coordinate
        self.mapView.setRegion(location: location, zoom: 4000, animated: true)
    }
    
}


extension MapController: SGMapViewDelegate {
    
    func didTapOnPin(card: FBAnnotation, data: BusinessData) {
        print("did tap on pin action")
        let controller = LocationDetailVC()
        controller.modalPresentationStyle = .overFullScreen
        controller.data = data
        controller.parentVC = self
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
    func didSelect(card: FBAnnotation, data: EventDetail) {
        print("didselect \(card.mapData)")
        let controller = EventDetailVC()
        controller.isFromEventList = true
        controller.eventId = data.eventId
        self.push(viewController: controller)
    }
    
    func didTapNavigation(card: FBAnnotation) {
        let data = card.mapData
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
        self.mapView.setRegion(lat: coordinate?.latitude ?? 0 , lng: coordinate?.longitude ?? 0, zoom: 4500, animated: true)
    }
}
