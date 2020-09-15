//
//  RationalNumbers+Conversion.swift
//  FitnessExtensions
//
//  Created by Vitali on 9/15/20.
//

import Foundation

public extension Float {
    var toIntegerPercents: Int {
        get {
            return Int(self * 100)
        }
    }
    var fromItegerPercentsToRatio: Float {
        get {
            return Float(self) / 100
        }
    }
}
