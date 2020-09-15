//
//  TPTraining.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import Foundation

public struct TPTraining {
    public var id: String?
    public var name: String?
    public var descriptionText: String?
    public var time: Date?
    
    public var sections: [TPTrainingSection]?
    
    public init(
        id: String?,
        name: String?,
        descriptionText: String?,
        time: Date?,
        sections: [TPTrainingSection]?
    ) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.time = time
        self.sections = sections
    }
    public init() {
        self.init(
            id: nil,
            name: nil,
            descriptionText: nil,
            time: nil,
            sections: nil
        )
    }
}
