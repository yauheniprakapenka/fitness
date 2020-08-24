//
//  UIScrollView+ContentSize.swift
//  fitnes
//
//  Created by Vitali on 8/25/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIScrollView {
    func resizeContentSizeToFitChilds() {
        var contentRect = CGRect.zero
        for view in subviews {
            contentRect = contentRect.union(view.frame)
        }
        contentSize = contentRect.size
    }
}
