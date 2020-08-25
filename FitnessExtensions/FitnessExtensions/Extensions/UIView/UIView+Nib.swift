//
//  UIView+Nib.swift
//  FitnessExtensions
//
//  Created by Vitali on 8/25/20.
//

import UIKit

public extension UIView {
    func viewNib(type viewType: AnyClass?) -> UINib {
        let viewTypeU: AnyClass = viewType ?? type(of: self)
        let bundle = Bundle(for: viewTypeU)
        let nibName = viewTypeU.description().components(separatedBy: ".").last!
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    func loadFromNib(type viewType: AnyClass?) -> UIView {
        let nib = viewNib(type: viewType)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
