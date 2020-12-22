//
//  WeatherManager.swift
//  Weather
//
//  Created by PRAVEEN on 16/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ :WeatherModel)
    
}

class WeatherManager {
    let halfURL = "https://api.openweathermap.org/data/2.5/weather?appid={your api key}&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let url = "\(halfURL)\(cityName)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            // Create URL session
            let session = URLSession(configuration: .default)
            
            // Give a task to URL session
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let p = decodedData.main.pressure
            let h = decodedData.main.humidity
            let name = decodedData.name
            let rise = decodedData.sys.sunrise
            let set = decodedData.sys.sunset
            let id = decodedData.weather[0].id
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            let main = decodedData.weather[0].main
            
            let weather = WeatherModel(latitude: lat, longitude: lon,conditionId: id, temperature: temp, cityName: name, humidity: h, pressure: p, description: main , sunrise: rise, sunset: set)
            
            return weather
            
        } catch  {
            return nil
        }
    }
}
