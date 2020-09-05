//
//  UIView+Constraints.swift
//  fitnes
//
//  Created by Vitali on 8/24/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

public extension UIView {
    func constraintAllSidesToSuperview(insets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = superview else {
            fatalError("View superview is nil")
        }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
    }
}
