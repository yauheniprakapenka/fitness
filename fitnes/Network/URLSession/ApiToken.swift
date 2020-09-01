//
//  ApiToken.swift
//  fitnes
//
//  Created by yauheni prakapenka on 01.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

struct TokenModel: Decodable {
    var accessToken: String?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}

import Foundation

extension NetworkManager {
    func getToken() {
        let postString = "grant_type=password&email=user67@example.com&password=12345678"
        
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
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
