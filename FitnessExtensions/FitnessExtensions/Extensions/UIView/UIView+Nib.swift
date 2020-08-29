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
    
    func defaultPrepareForInterfaceBuilder() {
        let colors: [UIColor] = [.blue, .green, .magenta, .red, .yellow]
        let label = UILabel(frame: frame)
        let text = type(of: self).description()
        let color = colors[abs(text.hashValue) % colors.count]
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.backgroundColor = color.withAlphaComponent(0.2)
        label.layer.borderWidth = 1
        label.layer.borderColor = color.cgColor
        addSubview(label)
    }
}
