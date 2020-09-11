//
//  CGSize+UIEdgeInsets.swift
//  FitnessExtensions
//
//  Created by Vitali on 8/26/20.
//

import UIKit

public extension CGSize {
    func applying(insets: UIEdgeInsets) -> CGSize {
        let newWidth = width + insets.left + insets.right
        let newHeight = height + insets.top + insets.bottom
        return CGSize(width: newWidth, height: newHeight)
    }
}
