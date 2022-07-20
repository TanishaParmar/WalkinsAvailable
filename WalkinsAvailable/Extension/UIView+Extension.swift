//
//  UIView+Extension.swift
//  WalkinsAvailable
//
//  Created by MyMac on 4/4/22.
//

import Foundation
import UIKit
import Kingfisher

// MARK: extension UIView
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
        self.layer.cornerRadius = cornerRadius

        // border
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

        // shadow
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4.0
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
    
    func addDashedBorder() {
      let color = UIColor.red.cgColor

      let shapeLayer:CAShapeLayer = CAShapeLayer()
      let frameSize = self.frame.size
      let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - 10, height: frameSize.height)

      shapeLayer.bounds = shapeRect
      shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.strokeColor = color
      shapeLayer.lineWidth = 2
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [6,3]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

      self.layer.addSublayer(shapeLayer)
      }
    
    
    @discardableResult
        func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
            let borderLayer = CAShapeLayer()

            borderLayer.strokeColor = color
            borderLayer.lineDashPattern = pattern
            borderLayer.frame = bounds
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

            layer.addSublayer(borderLayer)
            return borderLayer
        }

    
}


// MARK: extension String
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
    
    func convertTimeStampToString(timeStamp: String, format: String) -> String {
//        let date = Date(timeIntervalSince1970: timeStamp as? Double ?? 0.0)
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp) ?? 0.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}


// MARK: extension UIImageView
extension UIImageView {
    func setImage(url: String?, placeHolder: UIImage?) {
        if let urlst = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlst) {
            self.kf.setImage(with: url, placeholder: placeHolder, options: nil, completionHandler: nil)
        } else {
            self.image = placeHolder
        }
    }
    
    func getImage(url: String?, complition: @escaping((UIImage?)->Void)) {
        if let urlst = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlst) {
            self.kf.setImage(with: url, placeholder: nil, options: nil) { result in
                switch result {
                case .success(let img):
                    complition(img.image)
                default:
                    complition(nil)
                }
            }
        }
    }
}


// MARK: extension UIColor
extension UIColor {
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {

            // Convert hex string to an integer
            let hexint = Int(self.intFromHexString(hexStr: hexString))
            let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
            let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
            let blue = CGFloat((hexint & 0xff) >> 0) / 255.0

            // Create color object, specifying alpha as well
            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            return color
        }

        func intFromHexString(hexStr: String) -> UInt32 {
            var hexInt: UInt32 = 0
            // Create scanner
            let scanner: Scanner = Scanner(string: hexStr)
            // Tell scanner to skip the # character
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
            // Scan hex value
            hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
            return hexInt
        }
    
}
