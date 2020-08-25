//
//  UIView+Nib.swift
//  FitnessExtensions
//
//  Created by Vitali on 8/25/20.
//

import UIKit

public extension UIView {
    var viewNib: UINib {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    func loadFromNib() -> UIView {
        let nib = viewNib
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
