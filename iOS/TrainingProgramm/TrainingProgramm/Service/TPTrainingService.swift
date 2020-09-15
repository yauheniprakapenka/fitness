//
//  TPTrainingService.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/15/20.
//

import Foundation
import FitnessAPI

public enum TPTrainingServiceError: Error {
    case other
}

public typealias TPTrainingServiceResult<T> = Result<T, TPTrainingServiceError>

public extension TPTrainingService {
    typealias AddTrainingCompletionHandler = (TPExerciseServiceResult<Void>) -> Void
}

public class TPTrainingService {
    private init() {}
    public static let shared = TPTrainingService()
    private var authorization: String?
    private var authorizationParam: String {
        get {
            guard let token = authorization else {
                fatalError("Not initialized with authorization token")
            }
            return "Bearer \(token)"
        }
    }
    public func initialize(withAuthorizationToken token: String) {
        authorization = token
    }
    
    public func addTraining(_ training: TPTraining, userId: Int, completion: @escaping AddTrainingCompletionHandler) {
        
        let sections: [TrainingSection] = training.sections!.map { TrainingSection(section: $0 )}
        let body = CreateTrainingBody(name: training.name ?? "", trainerId: "\(userId)", startTime: "\(training.time)", description: training.descriptionText ?? "", sections: sections)
        
        let request = FitnessAPI.PostApiV1Trainings.Request(authorization: authorizationParam, body: body)
        
        APIClient.default.makeRequest(request, complete: { response in 
            switch response.result {
            case .success(let result):
                if let _ = result.success {
                    completion(.success(()))
                } else {
                    completion(.failure(.other))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.other))
            }
        })
    }
}

private extension TrainingSection {
    init(section: TPTrainingSection) {
        switch section {
        case .amrap(minutes: let minutes, items: let items, name: let name):
            self = .amrapOrForTimeTrainingSection(AmrapOrForTimeTrainingSection(minutes: minutes, items: items, name: name, type: "AMRAP"))
            
        case .emom(minutes: let minutes, items: let items, name: let name):
            self = .emomTrainingSection(EmomTrainingSection(minutes: minutes, items: items, name: name))
        case .forTime(minutes: let minutes, items: let items, name: let name):
            self = .amrapOrForTimeTrainingSection(AmrapOrForTimeTrainingSection(minutes: minutes, items: items, name: name, type: "FOR_TIME"))
        case .rest(minutes: let minutes, name: _):
            self = .restTrainingSection(RestTrainingSection(sectionType: "REST", startMinute: 0, duration: minutes.toDouble))
        }
    }
}

private extension EmomTrainingSection {
    convenience init(minutes: Int, items: [TPTrainingSectionItem], name: String?) {
        
        let actions: [EmomTrainingSection.Actions] = items.enumerated().map { (index, item) in
            let action = EmomTrainingSection.Actions(
                exerciseId: item.exercise?.id ?? -1,
                minute: index + 1,
                defaultValueMan: item.weightForManKg?.toDouble,
                defaultValueWoman: item.weightForWomanKg?.toDouble,
                distance: item.distanceMeters?.toDouble,
                profileIndex: String(item.profileValue ?? 0),
                ratio: item.koeff?.toIntegerPercents,
                reps: item.repeats)
            return action
        }
        
        self.init(
            sectionType: "EMOM",
            startMinute: 0,
            duration: minutes.toDouble,
            actions: actions)
    }
}

private extension AmrapOrForTimeTrainingSection {
    convenience init(minutes: Int, items: [TPTrainingSectionItem], name: String?, type: String) {
        
        let actions: [AmrapOrForTimeTrainingSection.Actions] = items.enumerated().map { (index, item) in
            let action = AmrapOrForTimeTrainingSection.Actions(
                exerciseId: item.exercise?.id ?? -1,
                defaultValueMan: item.weightForManKg?.toDouble,
                defaultValueWoman: item.weightForWomanKg?.toDouble,
                distance: item.distanceMeters?.toDouble,
                profileIndex: String(item.profileValue ?? 0),
                ratio: item.koeff?.toIntegerPercents,
                reps: item.repeats)
            return action
        }
        
        self.init(
            sectionType: type,
            startMinute: 0,
            duration: minutes.toDouble,
            actions: actions)
    }
}

