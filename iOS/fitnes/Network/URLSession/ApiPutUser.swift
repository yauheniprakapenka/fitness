//
//  ApiUdpateUser.swift
//  fitnes
//
//  Created by yauheni prakapenka on 06.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    func putUser(bodyData: AthelteProfileModel, completion: (() -> Void)? = nil) {
        
        let url = URL(string: baseURL + users + GetUserId.getUserId())
        guard let requestUrl = url else { return }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        var jsonString = ""
       
        if bodyData.userDataInt != nil {
            jsonString = "{\"\(bodyData.apiName ?? "")\":\(bodyData.userDataInt ?? 0)}"
        } else if bodyData.userDataString != nil {
            jsonString = "{\"\(bodyData.apiName ?? "")\":\"\(bodyData.userDataString ?? "string error")\"}"
        } else {
            print("Error: unknown user data type")
        }
        
        request.httpBody = jsonString.data(using: String.Encoding.utf8)
        
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
                print(userResponse)
                apiGetUserModel = userResponse
                completion?()
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
