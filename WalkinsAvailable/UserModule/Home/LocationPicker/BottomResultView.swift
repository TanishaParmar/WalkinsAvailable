//
//  BottomResultView.swift
//  meetwise
//
//  Created by hitesh on 23/11/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import UIKit

open class BottomResultView: UIView {

    //MARK: - Additional Views
    let label = UILabel()
    let selectButton = UIButton(type: .custom)
    let cancelButton = UIButton(type: .custom)
    
    private var didCancel:(()->())?
    private var didSelect:((LocationItem?)->())?
    
    
    var locationItem: LocationItem? {
        didSet {
            self.label.text = locationItem?.formattedAddressString
        }
    }
    
    //MARK: - result settings
    var resultText:String? {
        didSet {
            self.label.text = resultText
        }
    }
    var resultTextColor:UIColor = .green {
        didSet {
            self.label.textColor = resultTextColor
        }
    }
    var textSize:CGFloat = 16
    var resultFont: UIFont = UIFont.init(name: "Poppins-Medium", size: 20.0)! { // UIFont.setCustom(.OS_Regular, 14) {
        didSet {
            label.font = resultFont
        }
    }
    
    //MARK: - Button settings
    var buttonTitle:String = "Select Location" {
        didSet {
            setButton()
        }
    }
    var buttonFont: UIFont = UIFont.init(name: "Poppins-Medium", size: 20.0)! { // UIFont.setCustom(.OS_Regular, 14) {
        didSet {
            setButton()
        }
    }
    var buttonBackgroundColor: UIColor = .green {
        didSet {
            setButton()
        }
    }
    var buttonTitleColor: UIColor = .white {
        didSet {
            setButton()
        }
    }
    
    var cancelButtonTitle:String = "Cancel" {
        didSet {
            setButton()
        }
    }
    var cancelButtonTitleColor: UIColor = .green {
        didSet {
            setButton()
        }
    }
    
    var cancelButtonBackgroundColor: UIColor = .white {
        didSet {
            setButton()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.setView()
        self.setButton()
    }
    
    func setButton() {
        self.selectButton.setTitle(buttonTitle, for: .normal)
        self.selectButton.setTitleColor(buttonTitleColor, for: .normal)
        self.selectButton.backgroundColor = buttonBackgroundColor
        self.selectButton.titleLabel?.font = buttonFont
        self.selectButton.layer.cornerRadius = 7.0
        self.layer.cornerRadius = 7.0
        
        self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        self.cancelButton.setTitleColor(cancelButtonTitleColor, for: .normal)
        self.cancelButton.backgroundColor = cancelButtonBackgroundColor
        self.cancelButton.titleLabel?.font = buttonFont
        self.cancelButton.layer.cornerRadius = 7.0
        
        self.backgroundColor = .white
        
    }
    
    func setView() {
        label.numberOfLines = 3
        label.textAlignment = .center
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        selectButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        let buttonsStack = UIStackView(arrangedSubviews: [selectButton, cancelButton])
        
        buttonsStack.axis  = NSLayoutConstraint.Axis.horizontal
        buttonsStack.distribution  = UIStackView.Distribution.fillEqually
        buttonsStack.alignment = UIStackView.Alignment.leading
        buttonsStack.spacing = 10
        
        let verticalStack = UIStackView(arrangedSubviews: [label, buttonsStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(verticalStack)
        
        let verticalStackConstraints = [
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ]
        self.addConstraints(verticalStackConstraints)
        
        
        selectButton.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didCancel(_:)), for: .touchUpInside)
        
    }
    
    func setPreLocationView(isView: Bool) {
        if isView {
            self.selectButton.isHidden = true
            self.cancelButtonTitle = "Done"
            self.cancelButtonBackgroundColor = .black
            self.cancelButtonTitleColor = .white
        } else {
            self.selectButton.isHidden = false
        }
    }
    
    @objc private func didSelect(_ button:UIButton) {
        didSelect?(locationItem)
    }
    
    @objc private func didCancel(_ button:UIButton) {
        didCancel?()
    }
    
    open func callBacks(didSelect:((LocationItem?)->())?, didCancel:(()->())?) {
        self.didSelect = didSelect
        self.didCancel = didCancel
    }
}
