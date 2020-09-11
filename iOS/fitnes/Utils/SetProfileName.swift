//
//  SetProfileName.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class SetProfileName {
    
    static let shared = SetProfileName()
    
    func set(label: UILabel) {
        let noname = "Безымянный спортсмен"
        guard let name = apiGetUserModel.firstName else {
            label.text = noname
            return
        }
        
        if name.isEmpty {
            label.text = noname
            return
        }

        label.text = name
    }
}
