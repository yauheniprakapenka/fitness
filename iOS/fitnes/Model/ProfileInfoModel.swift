//
//  ProfileInfo.swift
//  fitnes
//
//  Created by yauheni prakapenka on 18.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

var profileInfoModel = ProfileInfoModel(email: "", uid: "", lastName: "", firstName: "", role: "")

struct ProfileInfoModel: Decodable {
    var email: String
    var uid: String
    var lastName: String
    var firstName: String
    var role: String
}
