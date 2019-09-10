//
//  WeatherReportViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 16/08/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class WeatherReportViewController: UIViewController {
    
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    
    var detailToDisplay:WeatherReport?
    let viewModel = WeatherAppViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Top view set up
        imageIcon.image = UIImage(named: detailToDisplay?.weather?.first?.icon ?? "01d.png")
        climateLabel.text = detailToDisplay?.weather?.first?.main
        descriptionLabel.text = detailToDisplay?.weather?.first?.weatherDescription
       
        // rest view set up
        maxTemp.text = "Maximum temperature :- \(String(describing: detailToDisplay?.main?.tempMax))°C"
        minTemp.text = "Minimum temperature :- \(String(describing: detailToDisplay?.main?.tempMin))°C"
        pressure.text = "Pressure :- \(String(describing: detailToDisplay?.main?.pressure)) hpa"
        
        sunrise.text = "Sunrise :- " + viewModel.convertTimestampToString(forTimestamp: (detailToDisplay?.sys?.sunrise)!, inTimezone: TimeZone(secondsFromGMT: (detailToDisplay?.timezone)!)!)
        sunset.text = "Sunset :- " + viewModel.convertTimestampToString(forTimestamp: (detailToDisplay?.sys?.sunset)!, inTimezone: TimeZone(secondsFromGMT: (detailToDisplay?.timezone)!)!)
        
    }

}
