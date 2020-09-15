//
//  TPTrainingSection.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/6/20.
//

import Foundation

public enum TPTrainingSection {
    case emom(minutes: Int, items: [TPTrainingSectionItem], name: String?)
    case amrap(minutes: Int, items: [TPTrainingSectionItem], name: String?)
    case forTime(minutes: Int, items: [TPTrainingSectionItem], name: String?)
    case rest(minutes: Int, name: String?)
    
    public var trainingType: TPTrainingType {
        switch self {
        case .emom: return .emom
        case .amrap: return .amrap
        case .forTime: return .forTime
        case .rest: return .rest
        }
    }
    
    public var items: [TPTrainingSectionItem]? {
        switch self {
        case .amrap(minutes: _, items: let items, name: _):
            return items
        case .emom(minutes: _, items: let items, name: _):
            return items
        case .forTime(minutes: _, items: let items, name: _):
            return items
        case .rest(minutes: _, name: _):
            return nil
        }
    }
    
    public var minutes: Int {
        switch self {
        case .amrap(minutes: let minutes, items: _, name: _): return minutes
        case .emom(minutes: let minutes, items: _, name: _): return minutes
        case .forTime(minutes: let minutes, items: _, name: _): return minutes
        case .rest(minutes: let minutes, name: _): return minutes
        }
    }
    
    public var name: String? {
        switch self {
        case .amrap(minutes: _, items: _, name: let name):
            return name
        case .emom(minutes: _, items: _, name: let name):
            return name
        case .forTime(minutes: _, items: _, name: let name):
            return name
        case .rest(minutes: _, name: let name):
            return name
        }
    }
    
    func withChangedTime(newMinutes: Int) -> Self {
        switch self {
        case .amrap(minutes: _, items: let items, name: let name):
            return .amrap(minutes: newMinutes, items: items, name: name)
        case .emom(minutes: _, _: let items, name: let name):
            return .emom(minutes: newMinutes, items: items, name: name)
        case .forTime(minutes: _, items: let items, name: let name):
            return .forTime(minutes: newMinutes, items: items, name: name)
        case .rest(minutes: _, name: let name):
            return .rest(minutes: newMinutes, name: name)
        }
    }
    
    func withChangedName(newName: String?) -> Self {
        switch self {
        case .amrap(minutes: let minutes, items: let items, name: _):
            return .amrap(minutes: minutes, items: items, name: newName)
        case .emom(minutes: let minutes, items: let items, name: _):
            return .emom(minutes: minutes, items: items, name: newName)
        case .forTime(minutes: let minutes, items: let items, name: _):
            return .forTime(minutes: minutes, items: items, name: newName)
        case .rest(minutes: let minutes, name: _):
            return .rest(minutes: minutes, name: newName)
        }
    }
}
