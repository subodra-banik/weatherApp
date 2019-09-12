//
//  WeatherAppDataModel.swift
//  Weather App
//
//  Created by Subodra Banik on 09/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation

// Using codable protocol

// Mark: - WeatherReport
struct WeatherReport: Codable {
    let weather: [Weather]?
    let main: Main?
    let sys: Sys?
    let timezone: Int?
    let name: String?
    let cod: Int
    let message: String?
}

// Mark: - Weather
struct Weather: Codable {
    let main: String?
    let weatherDescription: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
        case icon
    }
}

// Mark: - Main
struct Main: Codable {
    let temp: Double?
    let pressure: Double?
    let humidity: Double?
    let tempMin: Double?
    let tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise: Double?
    let sunset: Double?
}

// Mark: - Grouped weather report for 5 days in 3 hrs interval
struct GroupedWeather: Codable {
    let cod: String
    let city: City?
    let cnt: Int?
    let weatherArray: [WeatherArray]?
    
    enum CodingKeys: String, CodingKey {
        case cod
        case city
        case cnt
        case weatherArray = "list"
    }
}

// Mark: - City object
struct City: Codable {
    let name: String?
}

// Mark: - 5 days weather report 
struct WeatherArray: Codable {
    let main: Main?
    let weather: [Weather]?
    var day: String?
}
