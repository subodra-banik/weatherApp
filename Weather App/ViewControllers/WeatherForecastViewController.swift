//
//  WeatherForecastViewController.swift
//  Weather App
//
//  Created by Subodra Banik on 10/09/19.
//  Copyright © 2019 Subodra Banik. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    var location: String = ""
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var dayViewController: DayViewController = {
        // instantiate viewController
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "DayViewController") as! DayViewController
        viewController.location = self.location
        return viewController
    }()
    
    private lazy var weekViewController: WeekViewController = {
        // instantiate viewController
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "WeekViewController") as! WeekViewController
        viewController.location = self.location
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        initialContainerViewSetup()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Day", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Week", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // Select first segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func initialContainerViewSetup() {
        add(asChildViewController: dayViewController)
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    // change in segmented control
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: weekViewController)
            add(asChildViewController: dayViewController)
        } else {
            remove(asChildViewController: dayViewController)
            add(asChildViewController: weekViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }

}
