//
//  AnimatingView.swift
//  WalkinsAvailable
//
//  Created by apple on 28/04/22.
//


import UIKit

let SCREEN_SIZE = UIScreen.main.bounds


class AnimatingView: UIView {
    
    var align: NSTextAlignment = .center
    let indigator = UIActivityIndicatorView(style: .gray)
    
    init(height:CGFloat, align: NSTextAlignment = .center) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_SIZE.width, height: height))
        self.align = align
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        self.setViewLayout()
    }
    
    func setViewLayout() {
        indigator.backgroundColor = .clear
        self.addSubview(indigator)
        indigator.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = [
            indigator.topAnchor.constraint(equalTo: self.topAnchor),
            indigator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        switch align {
        case .left:
            let constraint = indigator.leftAnchor.constraint(equalTo: self.leftAnchor)
            constraints.append(constraint)
        case .right:
            let constraint = indigator.rightAnchor.constraint(equalTo: self.rightAnchor)
            constraints.append(constraint)
        default:
            let constraint = indigator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            constraints.append(constraint)
        }
        self.addConstraints(constraints)
        indigator.startAnimating()
    }
    
    
}
