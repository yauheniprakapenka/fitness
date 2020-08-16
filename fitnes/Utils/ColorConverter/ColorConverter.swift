//
//  ColorConverter.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class ColorConverter {
    
    static let shared = ColorConverter()
    
    func stringToColor(string: String) -> UIColor {
        var currentColor: UIColor!
        
        switch string {
        case "blue":
            currentColor = #colorLiteral(red: 0.3045426607, green: 0.6667945385, blue: 0.9780504107, alpha: 1)
        case "pink":
            currentColor = #colorLiteral(red: 1, green: 0.5700934529, blue: 0.6348041892, alpha: 1)
        case "orange":
            currentColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        default:
            currentColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        
        return currentColor
    }
}


