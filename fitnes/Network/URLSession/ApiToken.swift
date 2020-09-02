//
//  ApiToken.swift
//  fitnes
//
//  Created by yauheni prakapenka on 01.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getToken(email: String, password: String) {
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
                token = responseToken
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
