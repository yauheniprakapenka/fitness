//
//  ExercisesListModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

var exersisesList = ExercisesListModel(exercises: [])

struct ExercisesListModel: Decodable {
    var exercises: [String]
}
