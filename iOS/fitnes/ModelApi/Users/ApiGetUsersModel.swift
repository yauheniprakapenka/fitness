//
//  ApiGetUsersModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiGetUsersModel: Decodable {
    let data: [GetUsersData]?
}

struct GetUsersData: Decodable {
    let id: String?
    let attributes: GetUsersAttributes?
}

struct GetUsersAttributes: Decodable {
    let email: String?
    let firstName: String?
    let avatar: String?
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first-name"
        case avatar
        case phone
    }
}

var apiGetUsersModel = ApiGetUsersModel(data: nil)
