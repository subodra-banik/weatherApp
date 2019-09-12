//
//  ViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 14/08/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationText: UITextField!
    lazy var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationText.delegate = self
        viewModel.delegate = self
    }
    
    /*
     * Called when user clicks on clear button.
     */
    @IBAction func clearSearchTextField(_ sender: UIButton) {
        locationText.text = ""
    }
    
    /*
     * Called when user clicks on search button.
     */
    @IBAction func searchForGivenLocation(_ sender: UIButton) {
        viewModel.searchResults(for: self.locationText.text!)
    }
    
}


extension ViewController: ViewModelProtocol {
    
    /*
     * Function to load failed alert controller
     */
    func addingRequestFailedAlert(withMessage msg: String) {
        let msgToShow = "\(msg) \n Please try again!"
        // adding Alert to show failed request
        let failedRequestAlertController = UIAlertController(title: "Failed", message: msgToShow, preferredStyle: .alert)
        failedRequestAlertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(failedRequestAlertController, animated: true, completion: nil)
    }
    
    /*
     * Method : loading weather forecast report page with segmented control
     */
    func loadWeatherForecastViewController(for city: String) {
        if let weatherForecastVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherForecastViewController") as? WeatherForecastViewController {
            weatherForecastVC.title = city.uppercased()
            weatherForecastVC.location = city
            self.navigationController?.pushViewController(weatherForecastVC, animated: true)
        }
    }
    
}


extension ViewController: UITextFieldDelegate {

    /*
     * Called when 'return' key pressed by the user.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

