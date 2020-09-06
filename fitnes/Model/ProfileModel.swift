//
//  ProfileModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ProfileModel {
    var trainer: String?
    var client: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
}

var profile = ProfileModel(trainer: nil,
                           client: nil,
                           email: nil,
                           password: nil,
                           passwordConfirmation: nil,
                           firstName: nil,
                           lastName: nil,
                           phone: nil)
