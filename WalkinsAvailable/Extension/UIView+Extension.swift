//
//  UIView+Extension.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/4/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIView {
    func addShadowAndCornerRadius(view: UIView, cornerRadius: CGFloat, shadowColor: UIColor) {
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4.0
    }
    
    func addShadow(view: UIView, shadowColor: UIColor) {
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4.0
    }
    
    func addCornerRadius(view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
    
    func addCornerBorderAndShadow(view: UIView, cornerRadius: CGFloat, shadowColor: UIColor, borderColor: UIColor, borderWidth: CGFloat) {
        // corner radius
        view.layer.cornerRadius = cornerRadius

        // border
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor

        // shadow
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4.0
    }
    
//    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
//        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeft, topRightRadius: topRight, bottomLeftRadius: bottomLeft, bottomRightRadius: bottomRight)
//        let shape = CAShapeLayer()
//        shape.path = maskPath.cgPath
//        layer.mask = shape
//    }
    
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular) //systemMaterialDark
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = self.bounds
        blurEffectView.backgroundColor = .clear
        blurEffectView.effect = blurEffect
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func animShow() {
        self.center.y = +self.bounds.height
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
            self.center.y = self.bounds.midY
            self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],animations: {
            self.center.y = self.bounds.maxY*2
            self.layoutIfNeeded()
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
    
}



extension String{
    var trimWhiteSpace: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox
    }
    
}

extension UIImageView {
    func setImage(url: String?, placeHolder: UIImage?) {
        if let urlst = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlst) {
            self.kf.setImage(with: url, placeholder: placeHolder, options: nil, completionHandler: nil)
        } else {
            self.image = placeHolder
        }
    }
}
