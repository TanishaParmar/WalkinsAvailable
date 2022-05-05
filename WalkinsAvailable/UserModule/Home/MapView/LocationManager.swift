//
//  LocationManager.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//

import Foundation
import CoreLocation


class LocationManager : CLLocationManager {
    static let shared = LocationManager()
    var currentLocation: CLLocation?
    
    func getLocation() {
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.requestAlwaysAuthorization()
        self.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }
    
    class func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
    }
    
    class func geocode(locationItem: LocationItem?, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        guard let coorinate = locationItem?.coordinate else {return}
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coorinate.latitude, longitude: coorinate.longitude)) { completion($0?.first, $1) }
    }
    
    class func geocode(lat: Double, lng:Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        let location = CLLocation(latitude: lat, longitude: lng)
        CLGeocoder().reverseGeocodeLocation(location) { completion($0?.first, $1)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.currentLocation = CLLocation(latitude: 30.7333, longitude: 76.7794)
//        let location = locations.first
        self.currentLocation = location
        self.stopUpdatingLocation()
        print("get location ******* \(self.currentLocation)")
    }
    
}



extension CLPlacemark {
    
    func printValues() {
        print("name:", self.name ?? "")
        print("address1:", self.thoroughfare ?? "")
        print("address2:", self.subThoroughfare ?? "")
        print("city:",     self.locality ?? "")
        print("state:",    self.administrativeArea ?? "")
        print("zip code:", self.postalCode ?? "")
        print("country:",  self.country ?? "")
    }
    
    var city:String? {
        return self.locality
    }
    
    var state: String? {
        return self.administrativeArea
    }
    
    var address1:String? {
        return self.thoroughfare
    }
    
    var address2:String? {
        return self.subThoroughfare
    }
    
    
    var address: String {
        var addressString : String = ""
        let pm:CLPlacemark = self
        if pm.subLocality != nil {
            addressString += pm.subLocality! + ", "
        }
        if pm.thoroughfare != nil {
            addressString += pm.thoroughfare! + ", "
        }
        if pm.locality != nil {
            addressString += pm.locality! + ", "
        }
        if pm.country != nil {
            addressString += pm.country! + ", "
        }
        if pm.postalCode != nil {
            addressString += pm.postalCode! + " "
        }
        return addressString
    }
    
    
}
