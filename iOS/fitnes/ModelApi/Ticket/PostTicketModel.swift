//
//  PostTicketModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 12.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ApiPostTicketModel: Decodable {
    var id: Int?
    var duration: Int?
    var visits: Int?
    var price: Int?
}

var apiPostTicketModel = ApiPostTicketModel()
