//
//  WeekViewModel.swift
//  Weather App
//
//  Created by Subodra Banik on 11/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherViewModelProtocol: class {
    func addingActivityIndicator() -> Void
    func removingActivityIndicator() -> Void
    func addFailedRequestAlert(withMessage msg: String) -> Void
}

class WeekViewModel {
    
    lazy var apiService: WeatherAppServices = WeatherAppServices()
    weak var delegate: WeatherViewModelProtocol?
    weak var viewDelegate: WeekViewProtocol?
    lazy var weekWeather = [WeatherArray]()
    var dayInString = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    func callWebService(for city: String) {
        // Stopping user interaction, adding activity indicator
        delegate?.addingActivityIndicator()
        
        // trimming extra spcaces if present in the city name
        let cityName = city.trimmingCharacters(in: .whitespaces)
        
        // Api call to get current weather report
        apiService.fiveDayWeatherReport(for: cityName) { (weatherResponse, err) in
            self.delegate?.removingActivityIndicator()
            if let errMsg = err {
                self.delegate?.addFailedRequestAlert(withMessage: errMsg)
            } else {
                if let weather = weatherResponse {
                    self.updateWeekWeatherView(with: weather)
                }
            }
        }
    }
    
    private func updateWeekWeatherView(with groupedWeatherReport: GroupedWeather) {
        if let weatherArray = groupedWeatherReport.weatherArray, let count = groupedWeatherReport.cnt {
            if weatherArray.count == count {
                var i = 0
                if let dayOfWeek = Date().dayNumberOfWeek(){
                    var day = dayOfWeek - 1
                    while i < count {
                        self.weekWeather.append(weatherArray[i])
                        if i==0 {
                            weekWeather[weekWeather.count-1].day = "Today"
                        } else if i == 8 {
                            weekWeather[weekWeather.count-1].day = "Tomorrow"
                        } else {
                        weekWeather[weekWeather.count-1].day = dayInString[day]
                        }
                        i += 8
                        day = (day + 1) % 7
                    }
                    viewDelegate?.reloadTableView()
                    print(self.weekWeather)
                }
                
            }
        }
    }
    
    func registerCells(forTableView tableView: UITableView) {
        tableView.register(UINib.init(nibName: "WeeklyWeatherCell", bundle: nil), forCellReuseIdentifier: "WeeklyWeatherCell")
    }
    
    func numberOfRowsInSection(for section: Int) -> Int {
        if section == 0 {
            return 1 // for header
        } else {
            return self.weekWeather.count
        }
    }
    
    func getCellForRow(forTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyWeatherCell") as! WeeklyWeatherCell
        if indexPath.section == 0 {
            cell.customInit(forDay: "Day", maxTemp: "Max Temperature", minTemp: "Min Temperature")
        } else {
            if let day = weekWeather[indexPath.row].day, let maxi = weekWeather[indexPath.row].main?.tempMax, let mini = weekWeather[indexPath.row].main?.tempMin {
                cell.customInit(forDay: day, maxTemp: "\(maxi) ºC", minTemp: "\(mini) ºC")
            }
        }
        return cell
    }
   
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
