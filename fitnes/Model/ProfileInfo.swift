//
//  ProfileInfo.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct FitnesUser: Codable {
    var email: String
    var name: String
    var uid: String
    
    var profileInfo: String {
        """
        \(email)
        \(name)
        \(uid)
        """
    }
}

var fitnesUser = FitnesUser(email: "", name: "", uid: "")
