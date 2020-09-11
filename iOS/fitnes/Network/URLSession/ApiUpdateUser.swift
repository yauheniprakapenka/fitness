//
//  ApiUpdateUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func updateUser(completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + users + GetUserId.getUserId())
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let bodyData = "{\"trainer\":\"BORODACH\"}"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
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
}
