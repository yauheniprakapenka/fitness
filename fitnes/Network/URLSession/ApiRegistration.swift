//
//  ApiRegistration.swift
//  fitnes
//
//  Created by yauheni prakapenka on 31.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func makeRegistration(profile: ProfileModel,
                          resultCompletion: @escaping (Result<RegistrationModel, ApiErrorEnum>) -> Void,
                          completion: @escaping () -> Void) {
        
        let firstName = profile.firstName ?? ""
        let lastName = profile.lastName ?? ""
        let password = profile.password ?? ""
        let passwordConfirmation = profile.passwordConfirmation ?? ""
        let role = ConverterRoleToString.shared.fromModelToString(profile: profile)
        let email = profile.email ?? ""
        let phone = profile.phone ?? ""
        
        let postString = "first_name=\(firstName)&last_name=\(lastName)&password=\(password)&password_confirmation=\(passwordConfirmation)&\(role)&email=\(email)&phone=\(phone)"
        
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
                let responseRegistration = try decoder.decode(RegistrationModel.self, from: data)
                print(responseRegistration)
                
                if let userId = responseRegistration.userId {
                    registrationModel.userId = userId
                }

                if let responseMessage = responseRegistration.message {
                    switch responseMessage {
                    case "Complete registration on Service":
                        resultCompletion(.success(responseRegistration))
                        completion()
                        
                    case "Password and confirm password do not match":
                        resultCompletion(.failure(.passwordDoesNotMatch))
                    case "User exist":
                        resultCompletion(.failure(.userExist))
                    case "Incorrect password length. Range from 4 to 8 values":
                        resultCompletion(.failure(.incorrectPasswordLength))
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
