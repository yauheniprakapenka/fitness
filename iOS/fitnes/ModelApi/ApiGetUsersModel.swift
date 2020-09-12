//
//  ApiGetUsersModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiGetUsersModel: Decodable {
    let data: [Datum]?
}

struct Datum: Decodable {
    let id: String?
    let attributes: Attributes?
}

struct Attributes: Decodable {
    let email: String?
    let firstName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first-name"
        case avatar
    }
}

var apiGetUsersModel = ApiGetUsersModel(data: nil)
