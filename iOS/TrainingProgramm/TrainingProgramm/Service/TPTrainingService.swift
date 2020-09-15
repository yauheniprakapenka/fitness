//
//  TPTrainingService.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/15/20.
//
//swiftlint:disable private_over_fileprivate

import Foundation
import FitnessAPI

public enum TPTrainingServiceError: Error {
    case other
}

public typealias TPTrainingServiceResult<T> = Result<T, TPTrainingServiceError>

public extension TPTrainingService {
    typealias AddTrainingCompletionHandler = (TPExerciseServiceResult<Void>) -> Void
    typealias TrainingListCompletionHandler = (TPExerciseServiceResult<[TPTraining]>) -> Void
    typealias EditTrainingCompletionHandler = (TPExerciseServiceResult<Void>) -> Void
}

fileprivate let timeFormatter: DateFormatter = {
    let fm = DateFormatter()
    fm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return fm
}()

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
        let body = Training(name: training.name ?? "",
                            trainerId: "\(userId)",
                            startTime: "\(timeFormatter.string(from: training.time!))",
                            description: training.descriptionText ?? "",
                            sections: sections)
        
        let request = FitnessAPI.CreateTraining.Request(authorization: authorizationParam, body: body)
        
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
    
    public func trainingList(userId: Int, completion: @escaping TrainingListCompletionHandler) {
        
        let request = FitnessAPI.GetTrainingsListByTrainerId.Request(authorization: authorizationParam, trainerId: userId)
        APIClient.default.makeRequest(request) { response in
            switch response.result {
            case .success(let result):
                if let result = result.success {
                    let trainings = result.message.map { TPTraining(apiTraining: $0 )}
                    completion(.success(trainings))
                } else {
                    completion(.failure(.other))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.other))
            }
            
        }
    }
    
    public func editTraining(training: TPTraining, userId: Int, completion: @escaping EditTrainingCompletionHandler) {
        guard let id = training.id,
              let trainingId = Int(id)
        else {
            completion(.failure(.other))
            return
        }
        
        let sections: [TrainingSection] = training.sections!.map { TrainingSection(section: $0 )}
        let body = Training(
            name: training.name ?? "",
            trainerId: "\(userId)",
            startTime: "\(timeFormatter.string(from: training.time!))",
            description: training.descriptionText ?? "",
            sections: sections,
            id: trainingId
            )
        let request = FitnessAPI.ChangeTrainingById.Request(
            authorization: authorizationParam,
            id: trainingId,
            body: body)
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
        case .rest(minutes: let minutes, name: let name):
            self = .restTrainingSection(RestTrainingSection(sectionType: "REST", startMinute: 0, duration: minutes.toDouble, sectionName: name))
        }
    }
}

private extension EmomTrainingSection {
    convenience init(minutes: Int, items: [TPTrainingSectionItem], name: String?) {
        
        let actions: [EmomTrainingSection.Actions] = items.enumerated().map { (index, item) in
            let action = EmomTrainingSection.Actions(
                exerciseId: item.exerciseId ?? -1,
                minute: index + 1,
                defaultValueMan: item.defaultForMan?.toDouble,
                defaultValueWoman: item.defaultForWoman?.toDouble,
                distance: item.distanceMeters?.toDouble,
                profileIndex: item.profileValue,
                ratio: item.koeff?.toIntegerPercents,
                reps: item.repeats)
            return action
        }
        
        self.init(
            sectionType: "EMOM",
            startMinute: 0,
            duration: minutes.toDouble,
            actions: actions,
            sectionName: name
        )
    }
}

private extension AmrapOrForTimeTrainingSection {
    convenience init(minutes: Int, items: [TPTrainingSectionItem], name: String?, type: String) {
        
        let actions: [AmrapOrForTimeTrainingSection.Actions] = items.enumerated().map { (index, item) in
            let action = AmrapOrForTimeTrainingSection.Actions(
                exerciseId: item.exerciseId ?? -1,
                defaultValueMan: item.defaultForMan?.toDouble,
                defaultValueWoman: item.defaultForWoman?.toDouble,
                distance: item.distanceMeters?.toDouble,
                profileIndex: item.profileValue,
                ratio: item.koeff?.toIntegerPercents,
                reps: item.repeats)
            return action
        }
        
        self.init(
            sectionType: type,
            startMinute: 0,
            duration: minutes.toDouble,
            actions: actions,
            sectionName: name)
    }
}

private extension TPTraining {
    init(apiTraining training: Training) {
        if let id = training.id {
            self.id = String(id)
        }
        name = training.name
        descriptionText = training.description
        time = timeFormatter.date(from: training.startTime)
        sections = training.sections.map { TPTrainingSection(apiSection: $0 )}
    }
}

private extension TPTrainingSection {
    init(apiSection section: TrainingSection) {
        switch section {
        case .amrapOrForTimeTrainingSection(let amrapOrForTime):
            let time = amrapOrForTime.duration
            let items: [TPTrainingSectionItem]? = amrapOrForTime.actions?.map({ action in
                return TPTrainingSectionItem(apiAction: action)
            })
            switch amrapOrForTime.sectionType {
            case "AMRAP":
                self = .amrap(minutes: time.toInt, items: items ?? [], name: "Без названия")
            case "FOR_TIME":
                self = .forTime(minutes: time.toInt, items: items ?? [], name: "Без названия")
            default:
                fatalError("")
            }
        case .emomTrainingSection(let emom):
            let time = emom.duration
            let items: [TPTrainingSectionItem]? = emom.actions?.map({ action in
                return TPTrainingSectionItem(apiAction: action)
            })
            self = .emom(minutes: time.toInt, items: items ?? [], name: "Без названия")
        case .restTrainingSection(let rest):
            self = .rest(minutes: rest.duration.toInt, name: "Без названия")
        }
    }
}

private extension TPTrainingSectionItem {
    init(apiAction action: EmomTrainingSection.Actions) {
        exerciseId = action.exerciseId
        defaultForMan = action.defaultValueMan?.toFloat
        defaultForWoman = action.defaultValueWoman?.toFloat
        repeats = action.reps
        koeff = action.ratio?.toFloat.fromItegerPercentsToRatio
        distanceMeters = action.distance?.toInt
        profileValue = action.profileIndex
        
    }
    init(apiAction action: AmrapOrForTimeTrainingSection.Actions) {
        exerciseId = action.exerciseId
        defaultForMan = action.defaultValueMan?.toFloat
        defaultForWoman = action.defaultValueWoman?.toFloat
        repeats = action.reps
        koeff = action.ratio?.toFloat.fromItegerPercentsToRatio
        distanceMeters = action.distance?.toInt
        profileValue = action.profileIndex
    }
}
