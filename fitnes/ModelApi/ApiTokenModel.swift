//
//  TokenModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 01.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiTokenModel: Decodable {
    var accessToken: String?
    var tokenType: String?
    var error: String?
    var errorDescription: String?
    var userId: UInt32?
    var trainer: Bool?
    var client: Bool?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case error
        case errorDescription = "error_description"
        case userId = "user_id"
        case trainer
        case client
    }
}

var apiTokenModel = ApiTokenModel(trainer: false, client: false)
