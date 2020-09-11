//
//  RegistrationModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct CurrentProfileModel {
    var trainer: String?
    var client: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    var firstName: String?
    var lastName: String?
    var phone: String?
}

var currentProfileModel = RegistrationModel(trainer: nil,
                           client: nil,
                           email: nil,
                           password: nil,
                           passwordConfirmation: nil,
                           firstName: nil,
                           lastName: nil,
                           phone: nil)
