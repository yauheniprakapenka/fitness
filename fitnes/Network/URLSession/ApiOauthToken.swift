//
//  ApiToken.swift
//  fitnes
//
//  Created by yauheni prakapenka on 01.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getToken(email: String, password: String, completion: @escaping (Result<TokenModel, ApiErrorEnum>) -> Void) {
        let postString = "grant_type=password&email=\(email)&password=\(password)"
        
        let url = URL(string: baseURL + oauthToken)
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
                let responseToken = try decoder.decode(TokenModel.self, from: data)
                print(responseToken)
                tokenModel = responseToken
                
                if let responseToken = responseToken.error {
                    switch responseToken {
                    case "invalid_grant":
                        completion(.failure(.invalidGrant))
                        return
                    case IsInvalidPasswordError.handleMessage(message: responseToken):
                        completion(.failure(.invalidPassword))
                        return
                    default:
                        break
                    }
                }
                
                tokenModel = responseToken
                
                if tokenModel.accessToken != nil {
                    completion(.success(tokenModel))
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
