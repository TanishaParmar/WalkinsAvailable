//
//  FBAnnotation.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Kingfisher


class FBAnnotation: MKAnnotationView {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    var title: String? = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var sgDelegate: SGMapViewDelegate?
    var mapData: Any? {
        didSet {
            layoutSubviews()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    init(data: Any?) {
        super.init(annotation: nil, reuseIdentifier: nil)
        self.setChargerData(data: data)
    }
    
    init(value: (Double, Double)) {
        super.init(annotation: nil, reuseIdentifier: nil)
        
        let lat = value.0
        let lng = value.1
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setChargerData(data: Any?) {
        self.mapData = data
        
        if let data = data as? BusinessData {
            let lat = Double(data.latitude ?? "0") ?? 0.0
            let lng = Double(data.longitude ?? "0") ?? 0.0
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            print("BusinessData lat lng \(self.coordinate)")
            
            self.setPinImageView(url: data.image ?? "", backgroundImage: data.businessAvailability == "0" || data.businessAvailability == nil ? "locRed" : "locGreen")
        } else if let data = data as? EventDetail {
            let lat = Double(data.latitude ?? "0") ?? 0.0
            let lng = Double(data.longitude ?? "0") ?? 0.0
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            print("EventDetail lat lng \(self.coordinate)")
            self.setPinImageView(url: data.image ?? "", backgroundImage: "locBlack")
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    
    func setPinImageView(url originalURL: String, backgroundImage: String) { // set background images
        self.image = UIImage(named: "locGreen")
        if let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: originalURL) {
            let bgImage = UIImage(named: backgroundImage)
            self.image = MapPinImage.drawImageWithProfilePic(pp: image, image: bgImage!)
        } else {
            if let urlStr = originalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: urlStr) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url)  {
                        DispatchQueue.main.async {
                            let pp = UIImage(data: data)!
                            let bgImage = UIImage(named: backgroundImage)
                            KingfisherManager.shared.cache.store(pp, forKey: originalURL)
                            self.image = MapPinImage.drawImageWithProfilePic(pp: pp, image: bgImage!)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.image = UIImage(named: "locGreen")
                        }
                    }
                }
            }
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let data = self.mapData as? EventDetail {
            titleLabel.text = data.eventName
            titleLabel.textAlignment = .justified
            let stack = UIStackView(arrangedSubviews: [titleLabel])
            stack.spacing = 2.0
            
            self.detailCalloutAccessoryView = stack
            self.detailCalloutAccessoryView?.addTarget(target: self, action: #selector(targetAction))
            
            imageView.setImage(url: data.image, placeHolder: UIImage(named: "2")) 
            imageView.frame = CGRect(origin: .zero, size: CGSize(width: 25, height: 25))
            self.leftCalloutAccessoryView = imageView
        } else {
            self.addTarget(target: self, action: #selector(self.pinTapAction))
        }
    }
    
    @objc func pinTapAction() {
        print("pinTapAction performas")
        if let data = self.mapData as? BusinessData {
            self.sgDelegate?.didTapOnPin(card: self, data: data)
        }
    }
    
    @objc func navAction() {
        print("navAction performas")
        self.sgDelegate?.didTapNavigation(card: self)
    }
    
    @objc func targetAction() {
        print("targetAction performas")
        if let data = self.mapData as? EventDetail {
            self.sgDelegate?.didSelect(card: self, data: data)
        }
    }
    
    func sameCoordinate(_ coordinate: CLLocationCoordinate2D) -> Bool {
        return self.coordinate.latitude == coordinate.latitude &&  self.coordinate.longitude == coordinate.longitude
    }
    
}

extension FBAnnotation : MKAnnotation {
    
}

extension MKAnnotationView {
    func setCustomLines(customLines lines: [String]) {
        if lines.count <= 0 {
            return
        }
        // get longest line
        var longest = NSString()
        if let max = lines.max(by: { $1.count > $0.count }) {
            longest = max as NSString
        } else {
            fatalError("Can't get longest line.")
        }
        
        // get longest text width
        let font = UIFont.systemFont(ofSize: 15.0)
        let width = (longest.size(withAttributes: [NSAttributedString.Key.font: font])).width
        
        // get text from lines
        var text = lines.first
        for i in 1..<lines.count {
            text = text! + " " + lines[i]
        }
        
        // label
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = lines.count
        label.textAlignment = .justified
        
        // set width of label
        let con = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        label.addConstraint(con)
        
        self.detailCalloutAccessoryView = label
    }
}




extension UIView {
    
    func addTarget(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
}
