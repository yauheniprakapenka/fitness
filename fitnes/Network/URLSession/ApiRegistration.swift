//
//  ApiRegistration.swift
//  fitnes
//
//  Created by yauheni prakapenka on 31.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func registerUser(firstname: String,
                      lastname: String,
                      password: String,
                      passwordConfirmation: String,
                      email: String,
                      role: RoleEnum,
                      phone: String,
                      completion: @escaping (Result<RegistrationModel, ApiErrorEnum>) -> Void) {
        
        var currentRole = ""
        
        switch role {
        case .athlete:
            currentRole = "client=client"
        case .trainer:
            currentRole = "trainer=trainer"
        }
        
        let postString = "first_name=\(firstname)&last_name=\(lastname)&password=\(password)&password_confirmation=\(passwordConfirmation)&\(currentRole)&email=\(email)&phone=\(phone)"
        
        let url = URL(string: baseURL + registration)
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let registration = try decoder.decode(RegistrationModel.self, from: data)
                
                if let responseMessage = registration.message {
                    switch responseMessage {
                    case "Complete registration on Service":
                        completion(.success(registration))
                    case "Password and confirm password do not match":
                        completion(.failure(.passwordDoesNotMatch))
                    case "User exist":
                        completion(.failure(.userExist))
                    case "Incorrect password length. Range from 4 to 8 values":
                        completion(.failure(.incorrectPasswordLength))
                    default:
                        print("Неизвестный ответ: \(responseMessage)")
                    }
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
