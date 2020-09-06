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
        if apiRegistrationModel.userId != nil && apiRegistrationModel.userId != 0 {
            return String(apiRegistrationModel.userId ?? 0)
        } else if apiTokenModel.userId != nil && apiTokenModel.userId != 0 {
            return String(apiTokenModel.userId ?? 0)
        } else {
            return ""
        }
    }
}
