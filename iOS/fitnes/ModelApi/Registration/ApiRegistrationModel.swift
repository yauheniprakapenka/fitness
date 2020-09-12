//
//  RegistrationModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 30.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiRegistrationModel: Decodable {
    var message: String?
    var userId: UInt32?
    
    enum CodingKeys: String, CodingKey {
        case message
        case userId = "user_id"
    }
}

var apiRegistrationModel = ApiRegistrationModel()
