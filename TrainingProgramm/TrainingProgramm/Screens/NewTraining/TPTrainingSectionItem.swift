//
//  TPTrainingSectionItem.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/7/20.
//

import Foundation

public struct TPTrainingSectionItem {
    
    public var koeff: Float?
    public var exercise: TPExercise?
    public var profileValue: Float?
    public var weightForManKg: Float?
    public var weightForWomanKg: Float?
    public var repeats: Int?
    public var distanceMeters: Int?
    
    public init(
        koeff: Float?,
        exercise: TPExercise?,
        profileValue: Float?,
        weightForManKg: Float?,
        weightForWomanKg: Float?,
        repeats: Int?,
        distanceMeters: Int?
    ) {
        
        self.koeff = koeff
        self.exercise = exercise
        self.profileValue = profileValue
        self.weightForManKg = weightForManKg
        self.weightForWomanKg = weightForWomanKg
        self.repeats = repeats
        self.distanceMeters = distanceMeters
        
    }
    
    public init() {
        self.init(koeff: nil,
                  exercise: nil,
                  profileValue: nil,
                  weightForManKg: nil,
                  weightForWomanKg: nil,
                  repeats: nil,
                  distanceMeters: nil)
    }
}
