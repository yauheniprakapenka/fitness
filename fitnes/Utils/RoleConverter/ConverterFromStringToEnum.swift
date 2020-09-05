//
//  RoleToEnum.swift
//  fitnes
//
//  Created by yauheni prakapenka on 04.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class ConverterFromStringToEnum {
    
    static let shared = ConverterFromStringToEnum()
    
    func fromStringToEnum(role: String) -> RoleEnum? {
        switch role {
        case "Athlete":
            return .athlete
        case "Trainer":
            return .trainer
        default:
            return nil
        }
    }
}
