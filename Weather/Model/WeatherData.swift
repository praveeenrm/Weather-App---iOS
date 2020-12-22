//
//  WeatherData.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let sys: System
    let weather: [Weather]
    
    // For hour
    let coord: Coordination
}

struct Main: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}

struct System: Decodable {
    let sunrise: Double
    let sunset: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
}

struct Coordination: Decodable {
    let lon: Double
    let lat: Double
}
