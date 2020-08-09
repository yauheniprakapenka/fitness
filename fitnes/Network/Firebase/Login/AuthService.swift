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
    
    func createUser(withEmail: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {

        Auth.auth().createUser(withEmail: withEmail!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    func signIn(withEmail: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
}
