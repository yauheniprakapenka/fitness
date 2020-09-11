//
//  RoleToString.swift
//  fitnes
//
//  Created by yauheni prakapenka on 04.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class ConverterFromEnumToString {
    
    static let shared = ConverterFromEnumToString()
    
    func fromEnumToString(role: RoleEnum) -> String {
        switch role {
        case .athlete:
            return "client=true"
        case .trainer:
            return "trainer=true"
        }
    }
}
