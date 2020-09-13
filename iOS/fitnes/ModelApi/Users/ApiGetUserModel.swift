//
//  ApiGetUserModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiGetUserModel: Decodable {
    var firstName: String?
//    var lastName: String?
    var email: String?
    var phone: String?
    var birthDate: String?
    var sex: String?
    var weight: Int?
    var id: Int?
    var purchaseTime: String?
    var backSquat: Int?
    var frontSquat: Int?
    var cleanAndJerk: Int?
    var snatch: Int?
    var benchPress: Int?
    var deadlift: Int?
    var overheadPress: Int?
    var subscriptionId: Int?
    var ticketId: Int?
    var trainerId: Int?
    var duration: Int?
    var visits: Int?
    var price: Int?
    var attendanceTime: Int?
    var trainingId: Int?
    var tickets: Int?
    var club: String?
    var description: String?
    var trainer: Bool
    var client: Bool
    var height: Int?
    var avatar: String?
    var longitude: Double?
    var latitude: String?
    //      "attendances": [],
    //      "subscriptions": [],
   
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
//        case lastName = "last_name"
        case phone
        case birthDate
        case sex
        case purchaseTime
        case weight
        case backSquat
        case frontSquat
        case cleanAndJerk = "clean_and_jerk"
        case snatch
        case benchPress
        case deadlift
        case overheadPress
        case subscriptionId
        case ticketId
        case trainerId
        case duration
        case visits
        case price
        case attendanceTime
        case trainingId
        case tickets
        case club
        case description
        case trainer
        case client
        case height
        case avatar
        case longitude
        case latitude
    }
}

var apiGetUserModel = ApiGetUserModel(trainer: false, client: false)
