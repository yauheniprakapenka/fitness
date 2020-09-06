//
//  ApiGetUserModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

// MARK: - GetUserModel
struct ApiGetUserModel: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, type: String
    let links: DataLinks
    let attributes: Attributes
    let relationships: Relationships
}

// MARK: - Attributes
struct Attributes: Codable {
    let email, firstName, lastName, phone: String

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first-name"
        case lastName = "last-name"
        case phone
    }
}

// MARK: - DataLinks
struct DataLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Relationships
struct Relationships: Codable {
    let account, userContacts: Account

    enum CodingKeys: String, CodingKey {
        case account
        case userContacts = "user-contacts"
    }
}

// MARK: - Account
struct Account: Codable {
    let links: AccountLinks
}

// MARK: - AccountLinks
struct AccountLinks: Codable {
    let linksSelf, related: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case related
    }
}
