//
//  ViewController.swift
//  Weather
//
//  Created by PRAVEEN on 15/12/20.
//  Copyright © 2020 Praveen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, WeatherManagerDelegate, HourlyWeatherManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var weatherManager = WeatherManager()
    var hourlyWeatherManager = HourlyWeatherManager()
    var temperatureInArray = Array<Double>()
    var timeStringInArray = Array<String>()
    var arrayCount = 0
    
    @IBOutlet weak var mainCityLabel: UILabel!
    @IBOutlet weak var mainDegreeLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var myTextFileld: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTextFileld.delegate = self
        weatherManager.delegate = self
        hourlyWeatherManager.delegate = self
    }

    
    // Search Icon Button
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        myTextFileld.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextFileld.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = myTextFileld.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        myTextFileld.text = ""
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.mainCityLabel.text = weather.cityName
            self.mainDegreeLabel.text =  String(format: "%.0f", weather.temperature)
            self.sunriseLabel.text = weather.sunriseTimeInString
            self.sunsetLabel.text = weather.sunsetTimeInString
            self.descriptionLabel.text = weather.description
        }
        
        let latitude = weather.latitude
        let longitude = weather.longitude
        
        // Do networking for Hourly weather data
        hourlyWeatherManager.fetchHourlyWeather(lat: latitude, lon: longitude)
        
    }
    
    func didUpdateHourData(_ weather: HourlyWeatherModel) {
        DispatchQueue.main.async {
            self.temperatureInArray = weather.temparatures
            self.timeStringInArray = weather.timeInString
            self.arrayCount = self.temperatureInArray.count
            self.myTableView.reloadData()
        }
    }

    
    
    
//MARK: - TableView Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.selectionStyle = .none
        
        
        cell.dayLabel.text = timeStringInArray[indexPath.row]
        cell.dayLabel.textColor = UIColor.white


        cell.degreeLabel.text = String(format: "%.0f", temperatureInArray[indexPath.row])
        cell.degreeLabel.textColor = UIColor.white
        
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(60)
//    }
    
}



//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat, lon)
            hourlyWeatherManager.fetchHourlyWeather(lat: Double(lat), lon: Double(lon))
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


