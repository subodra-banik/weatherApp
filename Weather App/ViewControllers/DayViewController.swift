//
//  DayViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 11/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

protocol DayViewProtocol: class {
    func setWeatherImage(with id: String) -> Void
    func setMainTextLabel(with main: String) -> Void
    func setDescriptionLabel(with desc: String) -> Void
    func setMinTempTextLabel(with min: String) -> Void
    func setMaxTempTextLabel(with max: String) -> Void
    func setPressureTextLabel(with pressure: String) -> Void
    func setSunriseLabel(with sunrise: String) -> Void
    func setSunsetLabel(with sunset: String) -> Void
}

class DayViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    
    var location: String = ""
    
    lazy var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var viewModel: DayViewModel = DayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDelegate = self
        initialSetupView()
        viewModel.callWebService(for: location)
    }
    
    private func initialSetupView() {
        mainLabel.text = ""
        descriptionLabel.text = ""
        minTempLabel.text = ""
        maxTempLabel.text = ""
        pressureLabel.text = ""
        sunriseLabel.text = ""
        sunsetLabel.text = ""
    }
   
}

extension DayViewController: DayViewProtocol {
    
    func setWeatherImage(with id: String) {
        self.imageView.image = UIImage(named: id)
    }
    
    func setMainTextLabel(with main: String) {
        self.mainLabel.text = main
    }
    
    func setDescriptionLabel(with desc: String) {
        self.descriptionLabel.text = desc
    }
    
    func setMinTempTextLabel(with min: String) {
        self.minTempLabel.text = "Minimum Temperature :- \(min) ºC"
    }
    
    func setMaxTempTextLabel(with max: String) {
        self.maxTempLabel.text = "Maximum Temperature :- \(max) ºC"
    }
    
    func setPressureTextLabel(with pressure: String) {
        self.pressureLabel.text = "Pressure :- \(pressure) hpa"
    }
    
    func setSunriseLabel(with sunrise: String) {
        self.sunriseLabel.text = "Sunrise :- \(sunrise)"
    }
    
    func setSunsetLabel(with sunset: String) {
        self.sunsetLabel.text = "Sunset :- \(sunset)"
    }
    
}

extension DayViewController: WeatherViewModelProtocol {
    
    /*
     * Function to add an Activity Indicator to the srceen.
     */
    func addingActivityIndicator() -> Void {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = .gray
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /*
     * Function to remove activity indicator from the screen.
     */
    func removingActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    /*
     * Incase of error in request
     */
    func addFailedRequestAlert(withMessage msg: String) {
        let msgToShow = "\(msg) \n Please try again!"
        // adding Alert to show failed request
        let failedRequestAlertController = UIAlertController(title: "Failed", message: msgToShow, preferredStyle: .alert)
        failedRequestAlertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(failedRequestAlertController, animated: true, completion: nil)
    }
    
}
