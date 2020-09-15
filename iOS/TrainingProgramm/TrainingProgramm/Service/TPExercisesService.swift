//
//  TPExercisesService.swift
//  TrainingProgramm
//
//  Created by Vitali on 9/13/20.
//

import Foundation
import FitnessAPI

public enum TPExercisesServiceError: Error {
    case other
}

public typealias TPExerciseServiceResult<T> = Result<T, TPExercisesServiceError>

public extension TPExercisesService {
    typealias ExercisesListCompletionHandler = (TPExerciseServiceResult<[TPExercise]>) -> Void
    typealias AddExerciseCompletionHandler = (TPExerciseServiceResult<TPExercise>) -> Void
    typealias EditExerciseCompletionHandler = (TPExerciseServiceResult<TPExercise>) -> Void
    typealias RemoveExerciseCompletionHandler = (TPExerciseServiceResult<Void>) -> Void
}

public class TPExercisesService {
    private init() {}
    
    public static let shared = TPExercisesService()
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
    
    public func addExercise(_ exercise: TPExercise, userId: Int, completion: @escaping AddExerciseCompletionHandler) {
        let body = ExerciseCreationBody(from: exercise, userId: "\(userId)")
        let request = FitnessAPI.PostApiV1Exercises.Request(authorization: authorizationParam, body: body)
    
        APIClient.default.makeRequest(request, complete: { response in
            switch response.result {
            case .success(let result):
                if let _ = result.success {
                    completion(.success(exercise))
                } else {
                    completion(.failure(.other))
                }
            case .failure:
                completion(.failure(.other))
            }
        })
    }
    
    public func editExercise(_ exercise: TPExercise, userId: Int, completion: @escaping EditExerciseCompletionHandler) {
        guard let exerciseId = exercise.id else { fatalError() }
        
        let body = ExerciseEditingBody(description: exercise.description, equipment: exercise.inventory, name: exercise.name, videoUrl: exercise.video?.url.absoluteString)
        let request = FitnessAPI.PutApiV1ExercisesById.Request(id: exerciseId, authorization: authorizationParam, body: body)
        APIClient.default.makeRequest(request, complete: { response in
            switch response.result {
            case .success(let result):
                if let _ = result.success {
                    completion(.success(exercise))
                } else {
                    completion(.failure(.other))
                }
            case .failure:
                completion(.failure(.other))
            }
        })
    }
    
    public func exercisesList(userId: Int, completion: @escaping ExercisesListCompletionHandler) {
        let request = FitnessAPI.GetApiV1Exercises.Request(authorization: authorizationParam, userId: userId)
        APIClient.default.makeRequest(request, complete: { response in
            switch response.result {
            case .success(let result):
                if let success = result.success {
                    let exercises = success.message.map { item -> TPExercise in
                        let urlString = item.videoUrl ?? ""
                        let url = URL(string: urlString)
                        let video: VideoLink? = url != nil ? .remote(url: url!) : nil
                        return TPExercise(
                            name: item.name,
                            inventory: item.equipment,
                            description: item.description,
                            video: video,
                            id: item.id)
                    }
                    completion(.success(exercises))
                } else {
                    completion(.failure(TPExercisesServiceError.other))
                }
            case .failure(let error):
                print(error)
                completion(.failure(.other))
            }
        })
    }
    
}

extension ExerciseCreationBody {
    convenience init(from exercise: TPExercise, userId: String) {
        self.init(
            name: exercise.name ?? "Без имени",
            userId: userId,
            description: exercise.description,
            equipment: exercise.inventory,
            videoUrl: exercise.video?.url.absoluteString
        )
    }
}
