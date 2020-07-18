//
//  AuthService.swift
//  fitnes
//
//  Created by yauheni prakapenka on 15.07.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    // MARK: - Register
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard FieldValidator.shared.registerFieldsIsFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(FieldValidatorError.fieldIisNodFilled))
            return
        }
        
        guard password!.lowercased() == confirmPassword!.lowercased() else {
            completion(.failure(FieldValidatorError.passwordMismatch))
            return
        }
        
        guard FieldValidator.shared.isSimpleEmail(email: email!) else {
            completion(.failure(FieldValidatorError.invalidEmail))
            return
        }
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard FieldValidator.shared.loginFieldsIsFilled(email: email, password: password) else {
                completion(.failure(FieldValidatorError.fieldIisNodFilled))
                return
            }
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
}
