//
//  KeyboardHandler.swift
//  fitnes
//
//  Created by yauheni prakapenka on 16.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class KeyboardHandler {
    
    static let shared = KeyboardHandler()
    
    func dismissKeyboard(view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
}
