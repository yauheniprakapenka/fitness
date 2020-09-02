//
//  ApiGetUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getUser() {
        
        let url = URL(string: baseURL + users + String(registrationModel.userId ?? 0))
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
                let response = try decoder.decode(TokenModel.self, from: data)
                tokenModel = response
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
