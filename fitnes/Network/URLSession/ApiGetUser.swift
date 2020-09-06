//
//  ApiGetUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getUser(completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + users + getUserId())
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let accessToken = "Bearer \(tokenModel.accessToken ?? "missingToken")"
        request.setValue(accessToken, forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode(UserModel.self, from: data)
                print(userResponse)
                completion?()
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func getUserId() -> String {
        if registrationModel.userId != nil && registrationModel.userId != 0 {
            return String(registrationModel.userId ?? 0)
        } else if tokenModel.userId != nil && tokenModel.userId != 0 {
            return String(tokenModel.userId ?? 0)
        } else {
            return ""
        }
    }
}
