//
//  FBAnnotationCluster.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit


protocol FBAnnotationClusterDelegate {
    func didChange(annotations count:Int)
}

public class FBAnnotationCluster : NSObject {
    
    public var coordinate = CLLocationCoordinate2D(latitude: 39.208407, longitude: -76.799555)
    public var title: String? = "cluster"
    public var subtitle: String? = nil
    var delegate:FBAnnotationClusterDelegate?
    
    public var annotations: [MKAnnotation] = [] {
        didSet {
            self.delegate?.didChange(annotations: annotations.count)
        }
    }
}

extension FBAnnotationCluster : MKAnnotation {
    
}
