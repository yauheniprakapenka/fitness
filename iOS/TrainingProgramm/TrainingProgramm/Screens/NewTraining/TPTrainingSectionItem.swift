//
//  TPTrainingSectionItem.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/7/20.
//

import Foundation

public struct TPTrainingSectionItem {
    
    public var koeff: Float?
    public var exerciseId: Int?
    public var profileValue: String?
    public var defaultForMan: Float?
    public var defaultForWoman: Float?
    public var repeats: Int?
    public var distanceMeters: Int?
    
    public init(
        koeff: Float?,
        exerciseId: Int?,
        profileValue: String?,
        defaultForMan: Float?,
        defaultForWoman: Float?,
        repeats: Int?,
        distanceMeters: Int?
    ) {
        
        self.koeff = koeff
        self.exerciseId = exerciseId
        self.profileValue = profileValue
        self.defaultForMan = defaultForMan
        self.defaultForWoman = defaultForWoman
        self.repeats = repeats
        self.distanceMeters = distanceMeters
        
    }
    
    public init() {
        self.init(koeff: nil,
                  exerciseId: nil,
                  profileValue: nil,
                  defaultForMan: nil,
                  defaultForWoman: nil,
                  repeats: nil,
                  distanceMeters: nil)
    }
}
