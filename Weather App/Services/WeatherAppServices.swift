//
//  WeatherAppServices.swift
//  Weather App
//
//  Created by Subodra Banik on 09/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation
import Alamofire

class WeatherAppServices {
    
    let appID = "27ab3fbf7d357ce60d87a758c814719c"
    
    /*
     * Method : for getting weather report for a day
     */
    func dayWeatherReport(for city:String, completion: @escaping (WeatherReport?, String?) -> Void) {
        print("In\(city)")
        // API call using Alamofire
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(self.appID)&units=metric") {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in
                
                //now here we have the response data that we need to parse
                if let jsonData = response.data {
                    do{
                        //created the json decoder
                        let decoder = JSONDecoder()
                        
                        //variable to store the weather details, parsed json
                        let weatherReport = try decoder.decode(WeatherReport.self, from: jsonData)
                        
                        print("My parsed weatherReport: - \(weatherReport)")
                        
                        completion(weatherReport, nil)
                        
                    } catch {
                        completion(nil, "City not found!")
                    }
                } else {
                    completion(nil, "Problem in API response!")
                }
                
            })
        } else {
            completion(nil, "Problem in URL object creation!")
        }
    }
    
    /*
     * Method : for getting weather report for 5 days from today
     */
    func fiveDayWeatherReport(for city: String,  completion: @escaping (GroupedWeather?, String?) -> Void) {
        // API call using Alamofire
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(self.appID)&units=metric") {
            Alamofire.request(url).responseJSON(completionHandler: { (response) in
                
                //now here we have the response data that we need to parse
                if let jsonData = response.data {
                    do{
                        //created the json decoder
                        let decoder = JSONDecoder()
                        
                        //variable to store the weather details, parsed json
                        let weatherReport = try decoder.decode(GroupedWeather.self, from: jsonData)
                        
                        print("My parsed weatherReport: - \(weatherReport)")
                        if weatherReport.cod != "200" {
                            completion(nil, "Week weather data could not be found!")
                        } else {
                            completion(weatherReport, nil)
                        }
                        
                    } catch {
                        completion(nil, "City not found!")
                    }
                } else {
                    completion(nil, "Problem in API response!")
                }
                
            })
        } else {
            completion(nil, "Problem in URL object creation!")
        }
    }
    
}

