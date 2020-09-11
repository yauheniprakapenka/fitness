//
//  UIEdgeInsets+Utils.swift
//  FitnessExtensions
//
//  Created by Vitali on 8/29/20.
//

import UIKit

public extension UIEdgeInsets {
    static func allSides(by value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
