//
//  ApiGetTicketModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiGetTicketModel: Decodable {
    var data: GetTiketData?
}

struct GetTiketData: Decodable {
    var id: String?
    var type: String?
    var attributes: GetTiketAttributes?
}

struct GetTiketAttributes: Decodable {
    var duration: Int?
    var visits: Int?
    var price: Int?
}

var apiGetTicketModel = ApiGetTicketModel()
