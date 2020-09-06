//
//  GetUserId.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

struct GetUserId {
    static func getUserId() -> String {
        if registrationModel.userId != nil && registrationModel.userId != 0 {
            return String(registrationModel.userId ?? 0)
        } else if tokenModel.userId != nil && tokenModel.userId != 0 {
            return String(tokenModel.userId ?? 0)
        } else {
            return ""
        }
    }
}
