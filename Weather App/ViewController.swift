//
//  ViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 14/08/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var showError: UILabel!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    let viewModel = WeatherAppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    /**
    * Called when user clicks on clear button.
    */
    @IBAction func clearSearchTextField(_ sender: UIButton) {
        searchTextField.text = ""
    }
    
    /**
    * Called when user clicks on search button.
    */
    @IBAction func searchForGivenLocation(_ sender: UIButton) {
        
        // disabling user interaction, adding activity indicator.
        self.addingActivityIndicator()
        
        // api call
        self.viewModel.groupedWeatherForecast(for: self.locationText.text!, completion: {[weak self] (weatherReport, error) in
            
            // Disabling activity indicator
            self?.removingActivityIndicator()

            if error != nil {
                // adding Alert to show failed request
                let failedRequestAlertController = UIAlertController(title: "Failed", message: "Sorry! \(error!) \n Please try again!", preferredStyle: .alert)
                failedRequestAlertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                self?.present(failedRequestAlertController, animated: true, completion: nil)
            } else{
                if let weatherForecastVC = self?.storyboard?.instantiateViewController(withIdentifier: "WeatherForecastViewController") as? WeatherForecastViewController {
                    weatherForecastVC.title = weatherReport!.city?.name!
                    weatherForecastVC.weeklyArray = weatherReport!.weatherArray!
                    self?.navigationController?.pushViewController(weatherForecastVC, animated: true)
                }
            }
        })
    }
    
    /**
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
    
    /**
     * Function to remove activity indicator from the screen.
     */
    func removingActivityIndicator() -> Void {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}



extension ViewController: UITextFieldDelegate {

    /**
     * Called when 'return' key pressed by the user.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

