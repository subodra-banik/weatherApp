//
//  WeekViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 11/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

protocol WeekViewProtocol: class {
    func reloadTableView() -> Void
}

class WeekViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var location: String = ""
    
    lazy var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    lazy var viewModel: WeekViewModel = WeekViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDelegate = self
        viewModel.registerCells(forTableView: tableView)
        viewModel.callWebService(for: location)
    }

}

extension WeekViewController: WeatherViewModelProtocol {
    
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


extension WeekViewController: UITableViewDelegate, UITableViewDataSource, WeekViewProtocol {
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(for : section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCellForRow(forTableView: tableView, indexPath: indexPath)
    }
    
    
}
