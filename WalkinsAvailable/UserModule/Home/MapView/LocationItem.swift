//
//  LocationItem.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//


import MapKit


open class LocationItem: NSObject {
   
   public let mapItem: MKMapItem
   
   
   /// The name of the location. A reference to `MKMapItem` object's property `name`.
   open var name: String {
       return mapItem.name ?? ""
   }
   
   /// The coordinate of the location. A reference to `MKMapItem` object's property `placemark.coordinate` and converted to tuple. Only when the `allowArbitraryLocation` property of `LocationPicker` class is set to `true`, can this property be `nil`.
   open var coordinate: (latitude: Double, longitude: Double)? {
       let coordinate = mapItem.placemark.coordinate
       if CLLocationCoordinate2DIsValid(coordinate) {
           return coordinateTuple(fromObject: coordinate)
       } else {
           return nil
       }
   }
   
   /// The address dictionary of the location. A reference to `MKMapItem` object's property `placemark.addressDictionary`
   /// - Note: This dictionary along with a coordinate can be used to create a `MKPlacemark` object which can create a `MKMapItem` object.
   open var addressDictionary: [AnyHashable: Any]? {
       return mapItem.placemark.addressDictionary
   }
   
   /// The address of the location. This is the value to the key "FormattedAddressLines" in `addressDictionary`. It is the address text formatted according to user's region.
   /// - Note: If you would like to format the address yourself, you can use `addressDictionary` property to create one.
   
   open var formattedAddressString: String? {
//        addressDictionary?.keys.forEach({ key in
//            print("hashable ** \(key)  ** value = \(addressDictionary?[key])")
//        })
       
       guard let addressParts = (addressDictionary?["FormattedAddressLines"] as? [String]) else { return nil }
       
       return addressParts.joined(separator: ", ")
       //addressParts.count > 1 ? addressParts[1] : addressParts[0]
   }
   
   
   open override var hash: Int {
       if let coordinate = coordinate {
           return "\(coordinate.latitude), \(coordinate.longitude)".hash
       } else {
           return mapItem.name?.hash ?? "".hash
       }
   }
   
   open override var description: String {
       return "Location item with map item: " + mapItem.description
   }
   
   
   public init(mapItem: MKMapItem) {
       self.mapItem = mapItem
   }
   
   public init(coordinate: (latitude: Double, longitude: Double), addressDictionary: [String: AnyObject]) {
       let placeMark = MKPlacemark(coordinate: coordinateObject(fromTuple: coordinate), addressDictionary: addressDictionary)
       self.mapItem = MKMapItem(placemark: placeMark)
   }
   
   public init(locationName: String) {
       // Create map item with name and invalid placemark coordinate (since placemark is not optional in MKMapItem)
       let placeMark = MKPlacemark(coordinate: kCLLocationCoordinate2DInvalid, addressDictionary: nil)
       self.mapItem = MKMapItem(placemark: placeMark)
       self.mapItem.name = locationName
   }
   
   open override func isEqual(_ object: Any?) -> Bool {
       guard let object = object as AnyObject? else { return false }
       return object.hash == hash
   }
   
   public required convenience init(coder aDecoder: NSCoder) {
       let latitude = aDecoder.decodeDouble(forKey: "latitude")
       let longitude = aDecoder.decodeDouble(forKey: "longitude")
       let addressDictionary = aDecoder.decodeObject(forKey: "addressDictionary") as? [String: AnyObject] ?? [:]
       self.init(coordinate: (latitude, longitude), addressDictionary: addressDictionary)
   }
   
   public func encode(with aCoder: NSCoder) {
       aCoder.encode(mapItem.placemark.coordinate.latitude, forKey: "latitude")
       aCoder.encode(mapItem.placemark.coordinate.longitude, forKey: "longitude")
       aCoder.encode(addressDictionary, forKey: "addressDictionary")
   }
   
}


func coordinateTuple(fromObject coordinateObject: CLLocationCoordinate2D) -> (latitude: Double, longitude: Double) {
    return (latitude: coordinateObject.latitude, longitude: coordinateObject.longitude)
}

func coordinateObject(fromTuple coordinateTuple: (latitude: Double, longitude: Double)) -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: coordinateTuple.latitude, longitude: coordinateTuple.longitude)
}


extension CLLocationCoordinate2D {
    
    func isLocation(_ location: CLLocationCoordinate2D) -> Bool {
        return self.latitude == location.latitude && self.longitude == location.longitude
    }
    
}
