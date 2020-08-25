//
//  ProfileRoleModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

var currentProfleRole: RoleEnum = .athlete

class ProfileRoleModel {
    
    static let shared = ProfileRoleModel()
    
    func setProfileRole(index: Int) {
        switch index {
        case 0: currentProfleRole = .athlete
        case 1: currentProfleRole = .trainer
        default: print("ERROR: unknown profile role")
        }
    }
}
