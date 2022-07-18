//
//  UIImageView+Extension.swift
//  WalkinsAvailable
//
//  Created by MyMac on 7/18/22.
//

import Foundation
import UIKit


extension UIImageView {
    
    public func setImageView(urls urlStrings: [String], placeholder image: UIImage? = nil, item: Int = 0, controller: UIViewController? = nil) {
        print("urls count is *******  \(urlStrings)")
        guard urlStrings.filter({$0.count > 0}).count > 0 else { return }
        
        let urls = urlStrings.map { str -> URL in
            let val = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            return URL(string: val)!
        }
        guard urls.count > 0 else { return }
        let types: [ImageViewerOption] = [.theme(.blur)]
        self.setupImageViewer(urls: urls, initialIndex: item, options: types, from: controller)
        
        //        let url = URL(string: urlStrings[item].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        //        if isSkeleton {
        //            self.image = UIImage.gifImageWithName(name: "skeleton-loading")
        //        } else {
        //            self.setProgressView()
        //        }
        
//        self.setImage(image: urlStrings.first, placeholder: image)
        self.setImage(url: urlStrings[item], placeHolder: image)
    }
    
}
