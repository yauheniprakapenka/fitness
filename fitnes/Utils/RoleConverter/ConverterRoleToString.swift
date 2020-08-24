//
//  RoleToString.swift
//  fitnes
//
//  Created by yauheni prakapenka on 04.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class ConverterRoleToString {
    
    static let shared = ConverterRoleToString()
    
    func roleToString(role: RoleEnum?) -> String {
        switch role {
        case .athlete:
            return "Athlete"
        case .trainer:
            return "Trainer"
        default:
            return "Роль не найдена"
        }
    }
}
