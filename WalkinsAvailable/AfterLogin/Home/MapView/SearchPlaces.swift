//
//  SearchPlaces.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//


import Foundation
import MapKit

class SearchPlaces {
    
    static func searchFor(text searchText:String, complition:@escaping(([Location])->Void)) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.25 ) {
                
                guard let items = response?.mapItems else {
                    complition([])
                    return
                }
                let mapItems = items.map({Location(place: $0.placemark)})
                complition(mapItems)
            }
        }
    }
    
}

class Location: NSObject {
    
    
    let placemark: MKPlacemark
    
    init(place: MKPlacemark) {
        self.placemark = place
    }
    
    open var addressDictionary: [AnyHashable: Any]? {
        return self.placemark.addressDictionary
    }

    open var formattedAddressString: String? {
        guard let addressParts = (addressDictionary?["FormattedAddressLines"] as? [String]) else { return nil }
        return addressParts.joined(separator: ", ")
    }
    
    var address: String {
        print("full address is \(formattedAddressString)")
        print("full address is \(self.placemark.addressDictionary)")
        
        
        var address:String = ""
        if let a = addressDictionary?["City"] as? String {
            address += a
        }
        if let a = addressDictionary?["SubAdministrativeArea"] as? String {
            address += ", \(a)"
        }
        if let a = addressDictionary?["Country"] as? String {
            address += ", \(a)"
        }
        if let a = addressDictionary?["ZIP"] as? String {
            address += ", \(a)"
        }
        return address
    }
    
    
    var location:CLLocationCoordinate2D {
        get {
            return self.placemark.coordinate
        }
    }
    
    
}
