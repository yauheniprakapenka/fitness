//
//  Decoration.swift
//  CommonViews
//
//  Created by Vitali on 9/2/20.
//

import Foundation

public typealias Decoration<T> = (T) -> Void

public struct Decorator<T> {
    public let object: T
    public func apply(_ decorations: Decoration<T>...) {
            decorations.forEach({ $0(object) })
        }
}

public protocol DecoratorCompatible {
    associatedtype DecoratorCompatibleType
    var decorator: Decorator<DecoratorCompatibleType> { get }
}

public extension DecoratorCompatible {
    var decorator: Decorator<Self> {
        return Decorator(object: self)
    }
}
