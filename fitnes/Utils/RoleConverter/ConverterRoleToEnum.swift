//
//  RoleToEnum.swift
//  fitnes
//
//  Created by yauheni prakapenka on 04.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class ConverterRoleToEnum {
    
    static let shared = ConverterRoleToEnum()
    
    func roleToEnum(role: String) -> RoleEnum? {
        switch role {
        case "Athlete":
            return .Athlete
        case "Trainer":
            return .Trainer
        default:
            return nil
        }
    }
}
