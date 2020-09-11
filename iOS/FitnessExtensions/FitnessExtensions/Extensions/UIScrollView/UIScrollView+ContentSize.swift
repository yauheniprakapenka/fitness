//
//  UIScrollView+ContentSize.swift
//  fitnes
//
//  Created by Vitali on 8/25/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func resizeContentSizeToFitChilds() {
        var contentRect = CGRect.zero
        for view in subviews {
            contentRect = contentRect.union(view.frame)
        }
        contentSize = contentRect.size
    }
    
    func resizeContentSizeHeightToFitChildUsingAutolayout() {
        var height: CGFloat = 0
        for view in subviews {
            let size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            height += size.height
        }
        contentSize = CGSize(width: bounds.width, height: height)
    }
}
