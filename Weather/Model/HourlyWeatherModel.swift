//
//  HourlyWeatherModel.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

struct HourlyWeatherModel {
    let temparatures: [Double]
    let time: [Int]
    
    var timeInString: [String] {
        var t: [String] = []
        for i in time {
            let date = Date(timeIntervalSince1970: Double(i))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            t.append(localDate)
        }
        return t
    }
    
}

