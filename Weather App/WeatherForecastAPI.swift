//
//  File.swift
//  Weather App
//
//  Created by Subodra Banik on 16/08/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation
import Alamofire

//"https://api.openweathermap.org/data/2.5/weather?q=London&appid=\(apikey)"

//class WeatherForecastAPI {
//
//    let appID = "27ab3fbf7d357ce60d87a758c814719c"
//
//    /*
//    * function call for getting weather report for a day
//    */
//    func dayWeatherReport(for city:String, completion: @escaping (WeatherReport?, String?) -> Void) {
//
//        // API call using Alamofire
//        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appID)&units=metric") {
//            Alamofire.request(url).responseJSON(completionHandler: { (jsonData) in
//                do {
//                    let welcome = try JSONDecoder().decode(WeatherReport.self, from: jsonData.data!)
//                    print(welcome)
//                    completion(welcome,nil)
//                } catch {
//                    print(error.localizedDescription)
//                }
//
//                // queue printing
//                print("** \(Thread.current)")
//                if Thread.isMainThread {
//                    print("main")
//                } else {
//                    print(Thread.current)
//                }
//
////                if let jsonDict = response.result.value as? [String:Any] {
////                    print("O \(jsonDict)")
////                    if let main = jsonDict["main"] as? [String:Any], let sys = jsonDict["sys"] as? [String:Any], let weatherObject = jsonDict["weather"] as? [[String:Any]] {
////
////                        if let weather = weatherObject.first {
////                            var weatherDict = [String:Any]()
////                            weatherDict["name"] = city
////                            weatherDict.merge(dict: main)
////                            weatherDict.merge(dict: sys)
////                            weatherDict.merge(dict: weather)
////                            // success! weatherDict returned and error nil
////                            completion(WeatherReport(weatherDict: weatherDict), nil)
////                        }
////                    } else {
////                        completion(nil, "city not found!")
////                    }
////                } else {
////                    completion(nil, "API request failed!")
////                }
//            })
//        } else {
//            completion(nil, "Problem in URL object creation!")
//        }
//    }
//}
//
//
//
//
//
//
//
///*
// * To merge the above 3 dictionaries into a single dictionary
// */
////extension Dictionary {
////    mutating func merge(dict: [Key: Value]){
////        for (k, v) in dict {
////            updateValue(v, forKey: k)
////        }
////    }
////}
//
//
