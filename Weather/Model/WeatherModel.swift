//
//  WeatherModel.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let latitude: Double
    let longitude: Double
    
    let conditionId: Int
    let temperature: Double
    let cityName: String
    let humidity: Double
    let pressure: Double
    let description: String
    
    let sunrise: Double
    let sunset: Double
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
    
    var sunriseTimeInString: String {
        let sunriseTime = changeToLocalTime(id: sunrise)
        return sunriseTime
    }
    
    var sunsetTimeInString: String {
        let sunsetTime = changeToLocalTime(id: sunset)
        return sunsetTime
    }
    
    
    func changeToLocalTime(id: Double) -> String {
        let date = Date(timeIntervalSince1970: id)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

