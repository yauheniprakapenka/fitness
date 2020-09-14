//
//  ActivityIndicatorProtocol.swift
//  Common
//
//  Created by Vitali on 9/14/20.
//

import Foundation

public protocol ActivityIndicatorProtocol: class {
    func startIndicator()
    func stopIndicator()
    var isStarted: Bool { get }
}
