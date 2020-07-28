//
//  TrainerModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct TrainerModel: Decodable {
    var uid: String
    var name: String
}

var trainerInfo = TrainerModel(uid: "", name: "")
