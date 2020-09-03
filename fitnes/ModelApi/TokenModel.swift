//
//  TokenModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 01.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct TokenModel: Decodable {
    var accessToken: String?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

var tokenModel = TokenModel(accessToken: nil,
                       tokenType: nil)
