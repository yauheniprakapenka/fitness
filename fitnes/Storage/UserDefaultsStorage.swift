//
//  UserDefaultsStorage.swift
//  fitnes
//
//  Created by Vitali on 9/10/20.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class UserDefaultsStorage {
    static var shared = UserDefaultsStorage()
    private init() {}
    
    @UserDefaultStoredNullable(key: "previousEnteredLogin")
    var previousEnteredLogin: String?
}
