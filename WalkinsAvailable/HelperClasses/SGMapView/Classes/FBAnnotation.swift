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


class FBAnnotation : MKAnnotationView {
    
    let titleLabel = UILabel()
    let connectorLabel = UILabel()
    let outputLabel = UILabel()
    let imageView = UIImageView()
//    let rightButton: UIButton = UIButton(type: .detailDisclosure)
    
    var title: String? = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var sgDelegate: SGMapViewDelegate?
    var charger: ChargerData? {
        didSet {
            layoutSubviews()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    init(charger: ChargerData?) {
        super.init(annotation: nil, reuseIdentifier: nil)
        self.setChargerData(data: charger)
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
    
    func setChargerData(data: ChargerData?) {
        self.charger = data
        
        let lat = charger?.lat ?? 0
        let lng = charger?.lat ?? 0
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = "test 1"//self.charger?.publicName
        titleLabel.textAlignment = .justified
        
        connectorLabel.text = "test 2" //self.charger?.publicName
        connectorLabel.textAlignment = .justified
        
        outputLabel.textAlignment = .justified
        outputLabel.text = "test 3" //self.charger?.publicName
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, connectorLabel, outputLabel])
        stack.spacing = 2.0
        stack.axis = .vertical
        
        self.detailCalloutAccessoryView = stack
        self.detailCalloutAccessoryView?.addTarget(target: self, action: #selector(targetAction))
        
//        rightButton.setImage(UIImage(named: "Drive"), for: .normal)
//        rightButton.addTarget(self, action: #selector(navAction), for: .touchUpInside)
        imageView.image = UIImage(named: "2")
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: 25, height: 25))
        self.leftCalloutAccessoryView = imageView
    }
    
    @objc func navAction() {
        print("navAction performas")
        self.sgDelegate?.didTapNavigation(card: self)
    }
    
    @objc func targetAction() {
        print("targetAction performas")
        self.sgDelegate?.didSelect(card: self)
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
