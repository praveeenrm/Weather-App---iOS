//
//  HourlyWeatherData.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

struct HourlyWeatherData: Decodable {
    let hourly: [Hourly]
}

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
}
