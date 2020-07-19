//
//  ExerciseModel.swift
//  fitnes
//
//  Created by yauheni prakapenka on 19.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct ExerciseModel {
    var name: String
    var description: String
    var criteria: String
    var inventory: String
    var urlVideo: String
    var exerciseType: String
}

struct AllExercisesModel: Decodable {
    var exercises: [String]
}

var allExercises = AllExercisesModel(exercises: [])
