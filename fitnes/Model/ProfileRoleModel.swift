//
//  ProfileRoleModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

enum ProfileRoleEnum {
    case Athlete, Trainer
}

var currentProfleRole: ProfileRoleEnum = .Athlete

class ProfileRoleModel {
    
    static let shared = ProfileRoleModel()
    
    func setProfileRole(selectedSegmentIndex: Int) {
        switch selectedSegmentIndex {
        case 0:
            currentProfleRole = .Athlete
            print("Athlete")
        case 1:
            currentProfleRole = .Trainer
            print("Trainer")
        default: print("ERROR: unknown profile role")
        }
    }
}
