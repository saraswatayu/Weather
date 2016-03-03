//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/18/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Variables
    
    /// Open Weather API
    private var openWeather: OpenWeather {
        return OpenWeather.sharedInstance()
    }

    /// Outlets
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var errorLabel: UILabel?
    
    /// Weather Configuration
    var selectedCity = "New York, NY"
    
    
    /// Maintain View State
    enum WeatherViewControllerState: Int {
        case Loading, Ready, Error
    }
    
    var state: WeatherViewControllerState = .Loading {
        didSet {
            performOnMainThread() {
                self.temperatureLabel?.hidden = self.state != .Ready
                self.cityLabel?.hidden = self.state != .Ready
                self.activityIndicator?.hidden = self.state != .Loading
                self.errorLabel?.hidden = self.state != .Error
                
                if self.state == .Loading {
                    self.activityIndicator?.startAnimating()
                } else {
                    self.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        reloadWeather()
    }
    
    func reloadWeather() {
        state = .Loading
        
        openWeather.weather(city: selectedCity) {
            (weather) -> Void in
            guard let weather = weather else {
                self.state = .Error
                return
            }
            
            self.state = .Ready
            performOnMainThread() {
                self.temperatureLabel?.text = "\(weather.temperature)° F"
                self.cityLabel?.text = weather.city
            }
        }
    }
    
    @IBAction func dismissViewController(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}