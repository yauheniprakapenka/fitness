//
//  MonthConverter.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class MonthConverter {
    
    static let shared = MonthConverter()
    
    func convert(date: String) -> String {
        var month = date
        
        if month.contains("Aug") {
            month = "Август"
        } else if month.contains("Sep") {
            month = "Сентябрь"
        } else if month.contains("Oct") {
            month = "Октябрь"
        } else if month.contains("Nov") {
            month = "Ноябрь"
        } else if month.contains("Dec") {
            month = "Декабрь"
        } else if month.contains("Jan") {
            month = "Январь"
        } else if month.contains("Feb") {
            month = "Февраль"
        } else if month.contains("Mar") {
            month = "Март"
        } else if month.contains("May") {
            month = "Май"
        } else if month.contains("Jun") {
            month = "Июнь"
        } else if month.contains("Jul") {
            month = "Июль"
        }
        
        return month
    }
}
