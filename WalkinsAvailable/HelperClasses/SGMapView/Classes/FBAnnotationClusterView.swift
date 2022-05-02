//
//  FBAnnotationClusterView.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

class FBAnnotationClusterView : MKAnnotationView {
    
    var count = 0
    var fontSize: CGFloat = 12
    var imageName = "clusterSmall"
    var loadExternalImage: Bool = false
    let countLabel = UILabel()
    
    
    
    public init(annotation: MKAnnotation?, reuseIdentifier: String?, options: FBAnnotationClusterViewOptions?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setClusterView(options: options)
    }
    
    func setClusterView(options: FBAnnotationClusterViewOptions?) {
        let cluster: FBAnnotationCluster = annotation as! FBAnnotationCluster
        count = cluster.annotations.count
        cluster.delegate = self
        // change the size of the cluster image based on number of stories
        switch count {
        case 0...5:
            fontSize = 12
            if (options != nil) {
                loadExternalImage = true
                imageName = (options?.smallClusterImage)!
            } else {
                imageName = "clusterSmall"
            }
//            borderWidth = 3
        case 6...15:
            fontSize = 13
            if (options != nil) {
                loadExternalImage = true
                imageName = (options?.mediumClusterImage)!
            } else {
                imageName = "clusterMedium"
            }
//            borderWidth = 4
        default:
            fontSize = 14
            if (options != nil) {
                loadExternalImage = true
                imageName = (options?.largeClusterImage)!
            }
            else {
                imageName = "clusterLarge"
            }
//            borderWidth = 5
        }
        backgroundColor = UIColor.clear
//        setupLabel()
        setTheCount(localCount: count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    override func layoutSubviews() {
        // Images are faster than using drawRect:
        let imageAsset = UIImage(named: imageName)
        image = imageAsset
        centerOffset = CGPoint.zero
        setupLabel()
        
        // adds a white border around the green circle
//        layer.borderColor = UIColor.white.cgColor
//        layer.borderWidth = borderWidth
        layer.cornerRadius = self.bounds.size.width / 2
    }
    
    func setupLabel() {
        countLabel.frame = self.bounds
        countLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        countLabel.textAlignment = .center
        countLabel.backgroundColor = UIColor.clear
        countLabel.textColor = UIColor.white
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.minimumScaleFactor = 2
        countLabel.numberOfLines = 1
        countLabel.font = UIFont.systemFont(ofSize: fontSize)
        countLabel.baselineAdjustment = .alignCenters
        countLabel.text = "\(count)"
        addSubview(countLabel)
        print("label set up")
    }
    
    func setTheCount(localCount: Int) {
        count = localCount
        countLabel.text = "\(localCount)"
    }
    
}

extension FBAnnotationClusterView : FBAnnotationClusterDelegate {
    func didChange(annotations count: Int) {
        setClusterView(options: nil)
        self.count = count
        self.setTheCount(localCount: count)
        print("set cluster View \(self.count)")
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

public class FBAnnotationClusterViewOptions : NSObject {
    var smallClusterImage : String
    var mediumClusterImage : String
    var largeClusterImage : String
    
    public init(smallClusterImage: String, mediumClusterImage : String, largeClusterImage : String) {
        self.smallClusterImage = smallClusterImage;
        self.mediumClusterImage = mediumClusterImage;
        self.largeClusterImage = largeClusterImage;
    }
}

