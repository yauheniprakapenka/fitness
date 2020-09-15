//
//  ConversionToDifferentTypes.swift
//  FitnessExtensions
//
//  Created by Vitali on 9/15/20.
//

import Foundation

public extension Double {
    var toFloat: Float {
        return Float(self)
    }
    var toInt: Int {
        return Int(self)
    }
}

public extension Float {
    var toDouble: Double {
        return Double(self)
    }
    var toInt: Int {
        return Int(self)
    }
}

public extension Int {
    var toFloat: Float {
        return Float(self)
    }
    var toDouble: Double {
        return Double(self)
    }
}
