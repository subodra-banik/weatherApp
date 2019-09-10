//
//  WeatherForecastViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 10/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    var selectedSegmentIndex = 0
    var weeklyArray: [WeatherArray] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "WeeklyWeatherCell", bundle: nil)
        contentTableView.register(nib, forCellReuseIdentifier: "weekCell")
        
    }
    

    @IBAction func controlSegmentTapped(_ sender: UISegmentedControl) {
        
        self.selectedSegmentIndex = sender.selectedSegmentIndex
        contentTableView.reloadData()
        
    }
    

}

extension WeatherForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.selectedSegmentIndex == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.selectedSegmentIndex == 0 {
            return 0
        } else {
            if section == 0 {
                return 1
            } else {
                return self.weeklyArray.count
            }
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.selectedSegmentIndex == 0 {
            return UITableViewCell()
        } else {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "weekCell") as! WeeklyWeatherCell
            if indexPath.section == 0 {
                cell.headerInit(forDay: "Day", maxTemp: "Maximum Temperature", minTemp: "Minimum Temperature")
            } else {
                cell.customInit(forDay: "Today", maxTemp: (weeklyArray[indexPath.row].main?.tempMax)!, minTemp: (weeklyArray[indexPath.row].main?.tempMin)!)
            }
            return cell
        }
        
    }
    
    
}
