//
//  FBClusteringManager.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

public protocol FBClusteringManagerDelegate {
    
    func cellSizeFactorForCoordinator(coordinator: FBClusteringManager) -> CGFloat
    
}

public class FBClusteringManager : NSObject {
    
    public var delegate: FBClusteringManagerDelegate? = nil
    
    var tree: FBQuadTree? = nil
    
    var lock: NSRecursiveLock = NSRecursiveLock()
    
    public var maxZoomLevel = 1.0
    
    public override init(){
        super.init()
    }
    
    public init(annotations: [MKAnnotation]) {
        super.init()
        addAnnotations(annotations: annotations)
    }
    
    public func setAnnotations(annotations:[MKAnnotation]){
        tree = nil
        addAnnotations(annotations: annotations)
    }
    
    public func addAnnotations(annotations: [MKAnnotation]) {
        if tree == nil {
            tree = FBQuadTree()
        }
        lock.lock()
        for annotation in annotations {
            tree?.insertAnnotation(annotation: annotation)
        }
        print("annotations count \(annotations.count)")
        lock.unlock()
    }
    
    public func clusteredAnnotationsWithinMapRect(rect: MKMapRect, withZoomScale zoomScale: Double) -> [MKAnnotation]{
        guard !zoomScale.isInfinite else { return [] }
        
        var cellSize:CGFloat = FBClusteringManager.FBCellSizeForZoomScale(zoomScale: MKZoomScale(zoomScale))
        
        if let delegate = delegate {
            cellSize = delegate.cellSizeFactorForCoordinator(coordinator: self)
        }
        
        let scaleFactor:Double = zoomScale / Double(cellSize)
        
        let minX:Int = Int(floor(rect.minX * scaleFactor))
        let maxX:Int = Int(floor(rect.maxX * scaleFactor))
        let minY:Int = Int(floor(rect.minY * scaleFactor))
        let maxY:Int = Int(floor(rect.maxY * scaleFactor))
        
        var clusteredAnnotations = [MKAnnotation]()
        
        lock.lock()
        
        for i in minX...maxX {
            
            for j in minY...maxY {
                
                let mapPoint = MKMapPoint(x: Double(i)/scaleFactor, y: Double(j)/scaleFactor)
                
                let mapSize = MKMapSize(width: 1.0/scaleFactor, height: 1.0/scaleFactor)
                
                let mapRect = MKMapRect(origin: mapPoint, size: mapSize)
                let mapBox:FBBoundingBox  = FBQuadTreeNode.FBBoundingBoxForMapRect(mapRect: mapRect)
                
                var totalLatitude:Double = 0
                var totalLongitude:Double = 0
                
                var annotations = [MKAnnotation]()
                
                tree?.enumerateAnnotationsInBox(box: mapBox){ obj in
                    totalLatitude += obj.coordinate.latitude
                    totalLongitude += obj.coordinate.longitude
                    annotations.append(obj)
                }
                
                let count = annotations.count
                
                if count == 1 {
                    clusteredAnnotations += annotations
                }
                
                if count > 1 && zoomScale < self.maxZoomLevel {
                    let coordinate = CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(totalLatitude)/CLLocationDegrees(count),
                        longitude: CLLocationDegrees(totalLongitude)/CLLocationDegrees(count)
                    )
                    let cluster = FBAnnotationCluster()
                    cluster.coordinate = coordinate
                    cluster.annotations = annotations
                    clusteredAnnotations.append(cluster)
                } else {
                    clusteredAnnotations += annotations
                }
            }
        }
        lock.unlock()
        return clusteredAnnotations
    }
    
    public func allAnnotations() -> [MKAnnotation] {
        var annotations = [MKAnnotation]()
        lock.lock()
        tree?.enumerateAnnotationsUsingBlock() { obj in
            annotations.append(obj)
        }
        lock.unlock()
        return annotations
    }
    
    public func displayAnnotations(annotations: [MKAnnotation], onMapView mapView:MKMapView) {
        DispatchQueue.main.async {
            let before = NSMutableSet(array: mapView.annotations)
            before.remove(mapView.userLocation)
            let after = NSSet(array: annotations)
            let toKeep = NSMutableSet(set: before)
            toKeep.intersect(after as Set<NSObject>)
            let toAdd = NSMutableSet(set: after)
            toAdd.minus(toKeep as Set<NSObject>)
            let toRemove = NSMutableSet(set: before)
            toRemove.minus(after as Set<NSObject>)
            
            if let toAddAnnotations = toAdd.allObjects as? [MKAnnotation] {
                mapView.addAnnotations(toAddAnnotations)
            }
            if let removeAnnotations = toRemove.allObjects as? [MKAnnotation] {
                mapView.removeAnnotations(removeAnnotations)
            }
            print("annotations count \(annotations.count)")
        }
        
    }
    
    public class func FBZoomScaleToZoomLevel(scale:MKZoomScale) -> Int {
        let totalTilesAtMaxZoom:Double = MKMapSize.world.width / 256.0
        let zoomLevelAtMaxZoom:Int = Int(log2(totalTilesAtMaxZoom))
        let floorLog2ScaleFloat = floor(log2f(Float(scale))) + 0.5
        guard !floorLog2ScaleFloat.isInfinite else {
            return (floorLog2ScaleFloat < 0) ? 0 : 19
        }
        let sum:Int = zoomLevelAtMaxZoom + Int(floorLog2ScaleFloat)
        let zoomLevel:Int = max(0, sum)
        return zoomLevel;
    }
    
    public class func FBCellSizeForZoomScale(zoomScale:MKZoomScale) -> CGFloat {
        let zoomLevel: Int = FBClusteringManager.FBZoomScaleToZoomLevel(scale: zoomScale)
        switch (zoomLevel) {
        case 13:
            return 64
        case 14:
            return 64
        case 15:
            return 64
        case 16:
            return 32
        case 17:
            return 32
        case 18:
            return 32
        case 18 ..< Int.max:
            return 16
        default:
            return 88
        }
    }
    
}
