//
//  GetVideoId.swift
//  fitnes
//
//  Created by yauheni prakapenka on 10.09.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import Foundation

class GetIdFromYoutubeUrl {
    
    // MARK: - Public properties
    
    static let shared = GetIdFromYoutubeUrl()
    
    // MARK: - Public methods
    
    func getId(youtubeUrl: String) -> String {
        let lowerBound = String.Index(encodedOffset: getStartIndex(url: youtubeUrl))
        let upperBound = String.Index(encodedOffset: getLastIndex(url: youtubeUrl))
        let mySubstring: Substring = youtubeUrl[lowerBound..<upperBound]
        
        return String(mySubstring)
    }
}

// MARK: - Private methods

private extension GetIdFromYoutubeUrl {

    private func getStartIndex(url: String) -> Int {
        var index = 0
        var count = 0
        
        for item in url {
            count += 1
            
            if item == "=" {
                index = count
                break
            }
        }
        return index
    }

    private func getLastIndex(url: String) -> Int {
        var index = 0
        var count = 0
        
        for item in url {
            if item == "&" {
                index = count
                break
            }
            count += 1
        }
        return index
    }
}
