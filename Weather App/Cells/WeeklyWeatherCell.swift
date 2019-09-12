//
//  WeeklyWeatherCellTableViewCell.swift
//  Weather App
//
//  Created by Subodra Banik on 10/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class WeeklyWeatherCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customInit(forDay day: String, maxTemp max: String, minTemp min: String) {
        self.dayLabel.text = day
        self.maxTempLabel.text = max
        self.minTempLabel.text = min
    }

}
