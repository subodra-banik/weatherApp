//
//  WeatherReport.swift
//  Weather App
//
//  Created by Subodra Banik on 16/08/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation






// Using Dictionary and model class

/*
 * This class stores the current weather report properties
 */

//class WeatherReport {
//
//    let max_temp: Double?
//    let min_temp: Double?
//    let pressure: Double?
//    let sunset: String?
//    let sunrise: String?
//    let description: String?
//    let city: String?
//    let climate: String?
//    let icon: String?
//
//    struct weatherKey {
//        static let max_temp = "temp_max"
//        static let min_temp = "temp_min"
//        static let pressure = "pressure"
//        static let sunset = "sunset"
//        static let sunrise = "sunrise"
//        static let description = "description"
//        static let city = "name"
//        static let climate = "main"
//        static let icon = "icon"
//    }
//
//    init(weatherDict: [String: Any]) {
//        // for conversion of timestamp to readable date-time
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
//        dateFormatter.timeZone = .current
//
//        max_temp = weatherDict[weatherKey.max_temp] as? Double
//        min_temp = weatherDict[weatherKey.min_temp] as? Double
//        pressure = weatherDict[weatherKey.pressure] as? Double
//
//        if let sunsetTimestamp = weatherDict[weatherKey.sunset] {
//            let tempDate = Date(timeIntervalSince1970: sunsetTimestamp as! TimeInterval)
//            sunset = dateFormatter.string(from: tempDate)
//        } else {
//            sunset = nil
//        }
//        if let sunriseTimestamp = weatherDict[weatherKey.sunrise] {
//            let tempDate = Date(timeIntervalSince1970: sunriseTimestamp as! TimeInterval)
//            sunrise = dateFormatter.string(from: tempDate)
//        } else {
//            sunrise = nil
//        }
//
//        description = weatherDict[weatherKey.description] as? String
//        city = weatherDict[weatherKey.city] as? String
//        climate = weatherDict[weatherKey.climate] as? String
//        icon = weatherDict[weatherKey.icon] as? String
//    }
//
//    func printData() {
//        print("max_temp : ", max_temp ?? "nil")
//        print("min_temp : ", min_temp ?? "nil")
//        print("pressure : ", pressure ?? "nil")
//        print("sunset : ", sunset ?? "nil")
//        print("sunrise : ", sunrise ?? "nil")
//        print("description : ", description ?? "nil")
//        print("city : ", city ?? "nil")
//        print("climate : ", climate ?? "nil")
//        print("icon : ", icon ?? "nil")
//    }
//
//    func convertTimestampToString(timestamp: TimeInterval) -> String {
//        let tempDate = Date(timeIntervalSince1970: timestamp)
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
//        dateFormatter.timeZone = .current
//        let localDate = dateFormatter.string(from: tempDate)
//        return localDate
//    }
//}
