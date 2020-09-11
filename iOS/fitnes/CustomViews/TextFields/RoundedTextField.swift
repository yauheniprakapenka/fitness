//
//  FTextField.swift
//  fitnes
//
//  Created by yauheni prakapenka on 05.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 5)
    var borderColor: UIColor = .white {
        didSet {
            configure()
        }
    }
    var cornerRadius: CGFloat = 5 {
        didSet {
            configure()
        }
    }
    var borderWidth: CGFloat = 1 {
        didSet {
            configure()
        }
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(placeholderText: String, placeholderColor: UIColor) {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
