//
//  SetProflleDescription.swift
//  fitnes
//
//  Created by yauheni prakapenka on 08.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit

class SetProflleDescription {
    
    static let shared = SetProflleDescription()
    
    func set(label: UILabel) {
        let noname = "У меня все получится!"
        guard let name = apiGetUserModel.description else {
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
