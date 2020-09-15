//
//  ApiGetUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 02.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    func getUser(id: String?, completion: (() -> Void)? = nil) {
        var url = URL(string: "missing get user url")
        
        if id != nil {
            url = URL(string: baseURL + users + id!)
        } else {
            url = URL(string: baseURL + users + GetUserId.getUserId())
        }
        
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let accessToken = "Bearer \(apiTokenModel.accessToken ?? "missingToken")"
        request.setValue(accessToken, forHTTPHeaderField: "authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode(ApiGetUserModel.self, from: data)
                print(userResponse.createdSubscribers as Any)
//                apiGetUserModel = userResponse
                completion?()
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
