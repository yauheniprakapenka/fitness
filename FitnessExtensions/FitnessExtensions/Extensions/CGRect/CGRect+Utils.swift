//
//  CGRect+Utils.swift
//  FitnessExtensions
//
//  Created by Vitali on 8/29/20.
//

import UIKit

public extension CGRect {
    var center: CGPoint {
        return CGPoint(x: origin.x + width / 2, y: origin.y + width / 2)
    }
    var topLeft: CGPoint {
        return origin
    }
    var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }
    var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }
    var bottomRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }
    
    static func fromCenter(_ center: CGPoint, width: CGFloat, height: CGFloat) -> CGRect {
        let origin = CGPoint(x: center.x - width / 2, y: center.y - width / 2)
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
}
