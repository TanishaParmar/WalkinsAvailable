//
//  ErrorView.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 30/03/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.//

import UIKit

enum ERROR_TYPE {
    case error
    case success
    case message
    case notification
}

protocol ErrorDelegate {
    func removeErrorView()
}

class ErrorView: UIView {
    
    @IBOutlet var statusIcon: UIImageView!
    @IBOutlet var statusIconBgView: UIView!
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var effectView: UIVisualEffectView!
    
    
    var delegate: ErrorDelegate!
    var callBackFromError: ((Bool?) -> Void)?
    var pushData: PushModel?
    
    
    override func awakeFromNib() {
        errorMessage.textColor = .white
        errorMessage.font = UIFont.systemFont(ofSize: 14)
//        setCustom(.latoRegular, 14)
        
        self.statusIcon.image = #imageLiteral(resourceName: "w").withRenderingMode(.alwaysTemplate)
        self.statusIcon.tintColor = UIColor.white
        statusIcon.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideErrorMessageWithTap))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    func setErrorMessage(message: String, isError:ERROR_TYPE) {
        self.effectView.isHidden = true
        switch isError {
        case .error:
            self.backgroundColor = .errorColor
        case .success:
            self.backgroundColor = .successColor
        case .message:
            self.backgroundColor = .messageColor
        case .notification:
            self.effectView.isHidden = false
            self.backgroundColor = .clear
            self.errorMessage.textColor = .black
        }
        
        self.errorMessage.text = message
        let size = message.heightWithConstrainedWidth(width: SCREEN_SIZE.width-57, font: UIFont.systemFont(ofSize: 14))
        if size.height > 14 {
            self.frame.size.height = (HEIGHT.errorMessageHeight - 13) + size.height
//                + UIApplication.shared.statusBarFrame.height
            self.frame.origin.y = -self.frame.height
        }
        self.showErrorMessage()
    }
    
    func showErrorMessage() {
        let height = UIApplication.shared.statusBarFrame.height
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: self.frame.height + height)
        }, completion: { finished in
            self.perform(#selector(self.hideErrorMessageWithoutTap), with: nil, afterDelay: 3.0)
        })
    }
    
    @objc func hideErrorMessageWithTap() {
        if self.pushData != nil {
            self.callBackFromError?(true)
        }
        self.hideErrorMessageWithoutTap()
    }
    
    @objc func hideErrorMessageWithoutTap() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { finished in
            self.delegate.removeErrorView()
        })
    }
    
    func translateToBottom() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -(self.frame.height))
        }, completion: { finished in
            // self.delegate.removeErrorView()
        })
    }
    
    func translateToTop() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -(self.frame.height + Singleton.shared.keyboardSize.height))
        }, completion: { finished in
//            self.perform(#selector(self.hideErrorMessage), with: nil, afterDelay: 3.0)
        })
    }
    
}


extension UIColor {
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    open class var errorColor:UIColor {
        return UIColor.init(r: 226, g: 87, b: 76, a: 1)
    }
    
    open class var successColor:UIColor {
        return UIColor.init(r: 102, g: 208, b: 42, a: 1)
    }
    
    open class var messageColor:UIColor {
        return UIColor.init(r: 0, g: 0, b: 0, a: 0.9)
    }
}
