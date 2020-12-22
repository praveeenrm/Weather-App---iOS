//
//  HourlyWeatherManager.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

protocol HourlyWeatherManagerDelegate {
    func didUpdateHourData(_: HourlyWeatherModel)
}

struct HourlyWeatherManager {
    
    let halfURL = "https://api.openweathermap.org/data/2.5/onecall?appid={your api key}&units=metric&"
    
    var delegate: HourlyWeatherManagerDelegate?
    
    func fetchHourlyWeather(lat: Double, lon: Double) {
        let url = "\(halfURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let hourlyWeather = self.parseJSON(hourlyWeatherdata: safeData) {
                        self.delegate?.didUpdateHourData(hourlyWeather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(hourlyWeatherdata: Data) -> HourlyWeatherModel? {
        let decoder = JSONDecoder()
        do {
            var temps: [Double] = []
            var times: [Int] = []
            let decodedData = try decoder.decode(HourlyWeatherData.self, from: hourlyWeatherdata)
            let arr = decodedData.hourly
            
            for i in 0..<arr.count {
                temps.append(arr[i].temp)
                times.append(arr[i].dt)
            }
            
            let hourlyWeather = HourlyWeatherModel(temparatures: temps, time: times)
            return hourlyWeather
            
        } catch  {
            return nil
        }
        
    }
    
    
}
