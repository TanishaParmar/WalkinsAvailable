//
//  SGMapView.swift
//  CarCharger
//
//  Created by hitesh on 10/02/21.
//

import UIKit
import MapKit

protocol SGMapViewDelegate :NSObjectProtocol {
    func didSelect(card: FBAnnotation, data: EventDetail)
    func didTapNavigation(card: FBAnnotation)
    func didTapOnPin(card: FBAnnotation, data: BusinessData)
}

//LocationCardAnnotation
class SGMapView: MKMapView {
    var clusteringManager: FBClusteringManager!
    var array: [FBAnnotation] = []
    var pinImage: String = "1"
    var sgDelegate: SGMapViewDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("maps awakeFromNib")
        self.showsUserLocation = true
        
        self.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(BridgeAnnotation.self))
        self.register(FBAnnotation.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(FBAnnotation.self))
        self.register(LocationCardAnnotation.self, forAnnotationViewWithReuseIdentifier: LocationCardAnnotation.identifier)
        
    }
    
    
    
    func setRegion(lat:Double, lng:Double, zoom: Double, animated: Bool) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.setRegion(location: location, zoom: zoom, animated: animated)
    }
    
    func setRegion(location: CLLocationCoordinate2D, zoom: Double, animated: Bool) {
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: zoom, longitudinalMeters: zoom)
        self.setRegion(viewRegion, animated: animated)
        self.showsUserLocation = true
    }
    
    
    func setPinLocations(locations: [FBAnnotation]) {
        // drop two arbitrary pins somewhere near Louisville, Kentucky
        self.delegate = self
        
        clusteringManager = FBClusteringManager()
        array = locations
        print("locations count \(locations.count)")
        clusteringManager.addAnnotations(annotations: array)
        
//        self.removeAnnotations(array)
//        array = locations
//        self.addAnnotations(array)
        
    }
    
}

extension SGMapView: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapBoundsWidth = Double(self.bounds.size.width)
        
        let mapRectWidth = self.visibleMapRect.size.width
        let scale = mapBoundsWidth / mapRectWidth
        
        let annotationArray = self.clusteringManager.clusteredAnnotationsWithinMapRect(rect: self.visibleMapRect, withZoomScale: scale)        
        self.clusteringManager.displayAnnotations(annotations: annotationArray, onMapView: self)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is FBAnnotationCluster {
            return self.getClusterView(for: annotation)
        } else {
            print("annotation type is \(annotation)")
            if annotation.isKind(of: MKUserLocation.self) {
                // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
                return nil
            } else {
                return self.setupAnnotationView(for: annotation)
            }
        }
    }
    
}

//MARK:- SET ANNOTATION METHODS
extension SGMapView {
    private func setupAnnotationView(for annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = NSStringFromClass(FBAnnotation.self)
        var view = self.dequeueReusableAnnotationView(withIdentifier: identifier)
        if view == nil {
            view = self.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        }
        view?.image = UIImage(named: pinImage) // update image for business
        view?.canShowCallout = true
        if let index = array.firstIndex(where: {$0.coordinate.isLocation(annotation.coordinate)}) {
            if let fbAnnotaion = view as? FBAnnotation {
//                fbAnnotaion.rightButton.tag = index
                fbAnnotaion.setChargerData(data: array[index].mapData)
                fbAnnotaion.sgDelegate = self.sgDelegate
            }
        }
        return view
    }
    
    private func getClusterView(for annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "Cluster"
        let clusterView = self.dequeueReusableAnnotationView(withIdentifier: reuseId) as? FBAnnotationClusterView
        if clusterView != nil {
            clusterView?.removeFromSuperview()
        }
//        clusterView?.annotation = annotation
        return FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: nil)
    }
    
    
    
    
    
    @objc func navAction(_ button: UIButton) {
        print("navAction \(button)")
        self.sgDelegate?.didTapNavigation(card: array[button.tag])
    }
    
    @objc func selectAction(_ gesture: UITapGestureRecognizer) {
        let tag = gesture.view?.tag ?? 0
        print("navAction \(tag)")
        self.sgDelegate?.didSelect(card: array[tag], data: EventDetail())
    }
    
    
    @objc func selectPinTapAction(_ gesture: UITapGestureRecognizer) {
        let tag = gesture.view?.tag ?? 0
        print("navAction \(tag)")
        self.sgDelegate?.didTapOnPin(card: array[tag], data: BusinessData())
    }
    
}


