//
//  MapController.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/5/22.
//


import UIKit
import MapKit

class MapController: UIViewController {
    
    @IBOutlet weak var mapView: SGMapView!
    @IBOutlet weak var locationSearchTable: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var searchField: UITextField!
    
    var mapData: [MapData] = []
    var businessEventResponse: BusinessEventByLocationResponseModel?
    var businessTypeId: String?
    var timer: Timer?
    
    
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
        self.mapView.sgDelegate = self
        self.stackView.layer.cornerRadius = 12
        self.stackView.clipsToBounds = true
        self.setTableView()
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
    
    
    func generatingArtistHomeParameters(search: String) -> [String:Any] {
        let currentLoc = LocationManager.shared.currentLocation?.coordinate
        var params : [String:Any] = [:]
        params["businessTypeId"] = businessTypeId ?? ""
        params["search"] = search
        params["latitude"] = currentLoc?.latitude
        params["longitude"] = currentLoc?.longitude

        debugPrint("params data ** \(params)")
        return params
    }
    
    
    func hitBusinessEventListApi(search: String = "") {
        if search.count > 0 {
            let view = AnimatingView(height: 60, align: .center)
            view.backgroundColor = .white
            self.locationSearchTable.tableHeaderView = view
        } else {
            self.locationSearchTable.tableHeaderView = nil
            ActivityIndicator.sharedInstance.showActivityIndicator()
        }
        ApiHandler.updateProfile(apiName: API.Name.getBusinessAndEventByLocation, params: generatingArtistHomeParameters(search: search)) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                self.locationSearchTable.tableHeaderView = nil
                if succeeded {
                    if let response = DataDecoder.decodeData(data, type: BusinessEventByLocationResponseModel.self) {
                        print(response.allEvents?.count)
                        print(response.allBusinesses?.count)
                        self.businessEventResponse = response
                        if search.count > 0 {
                            self.locationSearchTable.reloadData()
                        } else {
                            self.setMapView(businesses: response.allBusinesses ?? [], events: response.allEvents ?? [])
                        }
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
        self.locationSearchTable.dataSource = self
        self.locationSearchTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setSearchAction() {
//        locationSearchBar.setActions {
//            DispatchQueue.main.async {
//                self.setTableData(places: [])
//            }
//        } searchResults: { (items) in
//            DispatchQueue.main.async {
//                self.setTableData(places: items)
//            }
//        } isSearching: { (isSearching) in
//            DispatchQueue.main.async {
//                if isSearching {
//                    let view = AnimatingView(height: 60, align: .center)
//                    view.backgroundColor = .white
//                    self.locationSearchTable.tableHeaderView = view
//                } else {
//                    self.locationSearchTable.tableHeaderView = nil
//                }
//            }
//        } searchButtonClicked: {
//            self.view.endEditing(true)
//            let height = self.locationSearchTable.frame.height
//            UIView.animate(withDuration: 0.25) {
//                self.locationSearchTable.transform = .init(scaleX: 0, y: height)
//            }
//        } searchBeginEditing: {
//            UIView.animate(withDuration: 0.25) {
//                self.locationSearchTable.transform = .identity
//            }
//        } searchEndEditing: {
//            let height = self.locationSearchTable.frame.height
//            UIView.animate(withDuration: 0.25) {
//                self.locationSearchTable.transform = .init(scaleX: 0, y: height)
//            }
//        }
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
    
    
    @objc func searchAction(_ timer: Timer) {
        guard let searchText = timer.userInfo as? String else { return }
        if searchText.count > 0 {
            hitBusinessEventListApi(search: searchText)
        } else {
            print("no text for searching")
        }
        
    }
    
    
    @IBAction func searchFieldBeginEditing(_ sender: UITextField) {
        UIView.animate(withDuration: 0.25) {
            self.locationSearchTable.transform = .identity
        }
    }
    
    @IBAction func searchFieldEndEditing(_ sender: UITextField) {
//        let height = self.locationSearchTable.frame.height
//        UIView.animate(withDuration: 0.25) {
//            self.locationSearchTable.transform = .init(scaleX: 0, y: height)
//        }
    }
    
    @IBAction func searchFieldEditingChanged(_ sender: UITextField) {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.searchAction(_:)), userInfo: sender.text, repeats: false)
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

extension MapController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.businessEventResponse?.allBusinesses?.count ?? 0
        } else {
            return self.businessEventResponse?.allEvents?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = self.businessEventResponse?.allBusinesses?[indexPath.row].businessName
        } else {
            cell.textLabel?.text = self.businessEventResponse?.allEvents?[indexPath.row].eventName
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setMapView(businesses: self.businessEventResponse?.allBusinesses ?? [], events: self.businessEventResponse?.allEvents ?? [])
        if indexPath.section == 0 {

            let lat = Double(self.businessEventResponse?.allBusinesses?[indexPath.row].latitude ?? "") ?? 0.0
            let long = Double(self.businessEventResponse?.allBusinesses?[indexPath.row].longitude ?? "") ?? 0.0
            //            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

            self.mapView.setRegion(lat: lat, lng: long, zoom: 4500, animated: true)
        } else {

            let lat = Double(self.businessEventResponse?.allEvents?[indexPath.row].latitude ?? "") ?? 0.0
            let long = Double(self.businessEventResponse?.allEvents?[indexPath.row].longitude ?? "") ?? 0.0
            //            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

            self.mapView.setRegion(lat: lat, lng: long, zoom: 4500, animated: true)
        }
        self.searchField.endEditing(true)
        let height = self.locationSearchTable.frame.height
        self.locationSearchTable.transform = .init(scaleX: 0, y: height)
    }
    
}

