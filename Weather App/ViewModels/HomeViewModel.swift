//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Subodra Banik on 09/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    func addingRequestFailedAlert(withMessage msg: String) -> Void
    func loadWeatherForecastViewController(for city: String) -> Void
}

class HomeViewModel {

    weak var delegate: ViewModelProtocol?
    
    /*
     * Method : will be called to search weather report
     */
    func searchResults(for location: String) -> Void {
        if location.isEmpty {
            delegate?.addingRequestFailedAlert(withMessage: "Enter a City")
        } else{
            delegate?.loadWeatherForecastViewController(for: location)
        }
        
    }
    
}

