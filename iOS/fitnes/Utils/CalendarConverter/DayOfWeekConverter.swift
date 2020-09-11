//
//  DayOfWeekConverter.swift
//  fitnes
//
//  Created by yauheni prakapenka on 09.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

class DayOfWeekConverter {
    
    static let shared = DayOfWeekConverter()
    
    func convert(date: String) -> String {
        var day = date
        
        if day.contains("Monday") {
            day = "Понедельник"
        } else if day.contains("Tuesday") {
            day = "Вторник"
        } else if day.contains("Wednesday") {
            day = "Среда"
        } else if day.contains("Thursday") {
            day = "Четверг"
        } else if day.contains("Friday") {
            day = "Пятница"
        } else if day.contains("Saturday") {
            day = "Суббота"
        } else if day.contains("Sunday") {
            day = "Воскресенье"
        }
        
        return day
    }
}
