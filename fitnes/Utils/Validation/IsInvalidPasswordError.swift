//
//  IsInvalidPasswordError.swift
//  fitnes
//
//  Created by yauheni prakapenka on 05.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

struct IsInvalidPasswordError {
    static func handleMessage(message: String) -> String {
        var errorMessage = ""
        
        if message.contains("Invalid password. Attempts left") {
            errorMessage = message
        }
        
        print(errorMessage)
        return errorMessage
    }
}
