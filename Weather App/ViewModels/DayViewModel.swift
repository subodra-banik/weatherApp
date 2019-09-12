//
//  DayViewModel.swift
//  Weather App
//
//  Created by Subodra Banik on 11/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation

class DayViewModel {
    
    lazy var apiService: WeatherAppServices = WeatherAppServices()
    weak var delegate: WeatherViewModelProtocol?
    weak var viewDelegate: DayViewProtocol?
    
    func callWebService(for city: String) {
        
        // Stopping user interaction, adding activity indicator
        delegate?.addingActivityIndicator()
        
        // trimming extra spcaces if present in the city name
        let cityName = city.trimmingCharacters(in: .whitespaces)
        
        // Api call to get current weather report
        apiService.dayWeatherReport(for: cityName) { (weatherResponse, err) in
            self.delegate?.removingActivityIndicator()
            if let errMsg = err {
                self.delegate?.addFailedRequestAlert(withMessage: errMsg)
            } else {
                if let weather = weatherResponse {
                    self.updateDayWeatherView(with: weather)
                }
            }
        }
    }
    
    
    func updateDayWeatherView(with weather: WeatherReport) {
        
        if let icon = weather.weather?.first?.icon {
            viewDelegate?.setWeatherImage(with: icon)
        }
        if let main = weather.weather?.first?.main {
            viewDelegate?.setMainTextLabel(with: main)
        }
        if let desc = weather.weather?.first?.weatherDescription {
            viewDelegate?.setDescriptionLabel(with: desc)
        }
        if let minTemp = weather.main?.tempMin {
            viewDelegate?.setMinTempTextLabel(with: String(describing: minTemp))
        }
        if let maxTemp = weather.main?.tempMax {
            viewDelegate?.setMaxTempTextLabel(with: String(describing: maxTemp))
        }
        if let pressure = weather.main?.pressure {
            viewDelegate?.setPressureTextLabel(with: String(describing: pressure))
        }
        if let timeInterval = weather.sys?.sunrise, let zone = weather.timezone, let timeZone = TimeZone(secondsFromGMT: zone) {
            viewDelegate?.setSunriseLabel(with: convertTimestampToString(forTimestamp: timeInterval, inTimezone: timeZone))
        }
        if let timeInterval = weather.sys?.sunset, let zone = weather.timezone, let timeZone = TimeZone(secondsFromGMT: zone) {
            viewDelegate?.setSunsetLabel(with: convertTimestampToString(forTimestamp: timeInterval, inTimezone: timeZone))
        }
    }
    
    /*
     *  Method : to convert timestamp to readable date and time string
     */
    func convertTimestampToString(forTimestamp timestamp: TimeInterval,inTimezone timezone: TimeZone) -> String {
        let tempDate = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "hh:mm:ss a"
        let localDate = dateFormatter.string(from: tempDate)
        return localDate
    }
}
