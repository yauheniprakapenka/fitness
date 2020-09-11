//
//  NumberOfDayConverver.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class NumberOfDayConverter {
    
    static let shared = NumberOfDayConverter()
    
    func convert(date: String) -> String {
        let substring = "-"
        
        var charCount = 0
        var countDash = 0
        
        var startIndex = 0
        var endIndex = 0
        
        for char in date {
            if substring.first == char {
                if countDash == 0 {
                    startIndex = charCount
                    countDash += 1
                } else if countDash == 1 {
                    endIndex = charCount
                    break
                }
            }
            
            charCount += 1
        }
        
        return date[startIndex + 1..<endIndex]
    }
}
