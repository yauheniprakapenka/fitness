//
//  TPExercise.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/2/20.
//

import Foundation

public struct TPExercise {
    public var id: Int?
    public var name: String?
    public var inventory: String?
    public var description: String?
    public var video: VideoLink?
    
    public init(name: String?,
                inventory: String?,
                description: String?,
                video: VideoLink?,
                id: Int? = nil) {
        self.name = name
        self.inventory = inventory
        self.description = description
        self.video = video
        self.id = id
    }
    
    public init() {
        self.init(name: nil, inventory: nil, description: nil, video: nil)
    }
}
