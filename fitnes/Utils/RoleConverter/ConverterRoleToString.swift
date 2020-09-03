//
//  RoleToString.swift
//  fitnes
//
//  Created by yauheni prakapenka on 04.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class ConverterRoleToString {
    
    static let shared = ConverterRoleToString()
    
    func fromEnumToString(role: RoleEnum?) -> String {
        switch role {
        case .athlete:
            return "Athlete"
        case .trainer:
            return "Trainer"
        default:
            return "Роль не найдена"
        }
    }
    
    func fromModelToString(profile: ProfileModel) -> String {
        var currentRole = "missing_role"
        
        if profile.client != nil {
            currentRole = "client=client"
        }
        
        if profile.trainer != nil {
            currentRole = "trainer=trainer"
        }
        
        return currentRole
    }
}
