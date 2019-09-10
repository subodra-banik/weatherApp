//
//  WeatherAppViewModel.swift
//  Weather App
//
//  Created by Subodra Banik on 09/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation



class WeatherAppViewModel {
    
    let services = WeatherAppServices()
    
    /*
     *  Method : to convert timestamp to readable date and time string
     */
    func convertTimestampToString(forTimestamp timestamp: TimeInterval,inTimezone timezone: TimeZone) -> String {
        let tempDate = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = timezone
        dateFormatter.dateFormat = "hh:mm"
        let localDate = dateFormatter.string(from: tempDate)
        return localDate
    }
    
    /*
     * Method : to get current weather forecast for a given location
     */
    func dayWeatherForecast(for location: String, completion: @escaping (WeatherReport?, String?) -> Void) {
        // trimming extra spcaces if present in the city name
        let city = location.trimmingCharacters(in: .whitespaces)
        
        services.dayWeatherReport(for: city) { (weatherReport, err) in
            completion(weatherReport, err)
        }
    
    }
    
    /*
     * Method : to get 5 days weather forecast for a given location
     */
    func groupedWeatherForecast(for location: String, completion: @escaping (GroupedWeather?, String?) -> Void) {
        // trimming extra spcaces if present in the city name
        let city = location.trimmingCharacters(in: .whitespaces)
        
        services.fiveDayWeatherReport(for: city) { (weatherReport, err) in
            if let err = err {
                completion(nil,err)
            } else {
                completion(weatherReport,nil)
            }
        }
    }
    
}

