//
//  LocationCardAnnotation.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//


import UIKit
import MapKit

class LocationCardAnnotation: NSObject, MKAnnotation {
    
    static let identifier = "LocationCardAnnotation"
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.810_000, longitude: -122.477_450)
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String? //= NSLocalizedString("BRIDGE_TITLE", comment: "Bridge annotation")
    
    // This property defined by `MKAnnotation` is not required.
    var subtitle: String? //= NSLocalizedString("BRIDGE_SUBTITLE", comment: "Bridge annotation")
    
    
    private let navButton: UIButton = {
        let btn = UIButton(type: .detailDisclosure)
        btn.setImage(UIImage(named: "Drive"), for: .normal)
        btn.addTarget(self, action: #selector(navAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func navAction(_ button: UIButton) {
        
    }
    
    
//    override func layoutSubviews() {
//        self.animatesWhenAdded = true
//        self.canShowCallout = true
//        self.markerTintColor = .IC_RobinBlue_Controls
//        self.rightCalloutAccessoryView = navButton
//    }
    
    
    
//    var title: String? = "" {
//        didSet {
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
//        }
//    }
//    var connector: String? = "" {
//        didSet {
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
//        }
//    }
//    var output: String? = "" {
//        didSet {
//            self.setNeedsLayout()
//            self.layoutIfNeeded()
//        }
//    }
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.setLabel(nil, .IC_Blue1, .rMedium, 12)
//        return label
//    }()
//    private let connectorLabel: UILabel = {
//        let label = UILabel()
//        let textColor: UIColor = UIColor.IC_Blue1.with(alpha: 0.5)
//        label.setLabel(nil, textColor, .rRegular, 12)
//        return label
//    }()
//    private let outputLabel: UILabel = {
//        let layer = UILabel()
//        return layer
//    }()
//    private let navigationButton: UIButton = {
//        let layer = UIButton()
//        layer.setImage(UIImage(named: "Drive"), for: .normal)
//        layer.frame = CGRect(x: 107, y: 24, width: 30, height: 30)
//        return layer
//    }()
//    private let line:UIView = {
//        let view = UIView()
//        view.frame = CGRect(x: 4, y: 36, width: 80, height: 0.5)
//        view.backgroundColor = .separatorColor
//        return view
//    }()
//
//    private let contentView : UIView = UIView()
//    var charger: ChargerData?
//    var delegate: LocationCardDelegate?
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.layoutSubviews()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.backgroundColor = .white
//        contentView.frame = self.bounds
//        self.addSubview(self.contentView)
//        setTitleLayer()
//        setConnectorLayer()
//        setOutputLayer()
//        setImageLayer()
//    }
//
//    private func setTitleLayer() {
//        titleLabel.frame = CGRect(x: 4, y: 2, width: 132, height: 13)
//        addSubview(titleLabel)
//    }
//
//    private func setConnectorLayer() {
//        connectorLabel.frame = CGRect(x: 4, y: 18, width: 120, height: 11)
//        addSubview(connectorLabel)
//    }
//
//    private func setOutputLayer() {
//        outputLabel.frame = CGRect(x: 4, y: 41, width: 100, height: 11)
//        let font = UIFont.setCustom(.rMedium, 10)
//        outputLabel.setAttributed(str1: output ?? "", font1: font, color1: .IC_Yellow1, str2: " /kW", font2: font, color2: .placeholderColor)
//        addSubview(outputLabel)
//    }
//
//    private func setImageLayer() {
//        self.addSubview(navigationButton)
//        self.addSubview(line)
//        self.navigationButton.addTarget(self, action: #selector(navitaionTarget(_:)), for: .touchUpInside)
//        self.isUserInteractionEnabled = true
//        self.addTarget(target: self, action: #selector(navitaionTarget(_:)))
//    }
//
//
//    @objc func navitaionTarget(_ button:UIButton) {
//        self.delegate?.didSelect(charger)
//    }
//
//    @objc func didSelectCardAction(_ button:UIButton) {
//        self.delegate?.didTapNavigation(charger)
//    }
//
//    func setCharger(data: ChargerData?) {
//        self.charger = data
//        self.title = data?.chargerName
//        self.connector = data?.connectorType?.name
//        self.output = data?.output
//    }
//
//
//
//
//
//
//
//
    

}


//MARK:- BridgeAnnotation
class BridgeAnnotation: MKMarkerAnnotationView {
    
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 37.810_000, longitude: -122.477_450)
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String? = NSLocalizedString("BRIDGE_TITLE", comment: "Bridge annotation")
    
    // This property defined by `MKAnnotation` is not required.
    var subtitle: String? = NSLocalizedString("BRIDGE_SUBTITLE", comment: "Bridge annotation")
    
//    var charger: ChargerData? {
//        didSet {
//            self.setCharger()
//        }
//    }
//
//    func setCharger() {
//        self.title = charger?.chargerName
//        self.subtitle = "\(charger?.connectorType?.name ?? "")\n\(charger?.output ?? "")Kw"
//    }
    
    
}
