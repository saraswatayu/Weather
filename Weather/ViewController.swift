//
//  ViewController.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/18/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let openWeatherAPI = OpenWeather(key: "c0dc8424266dd7a65999bad7f9632a88")
        openWeatherAPI.weather(city: "New York City, NY") {
            (data, error) -> Void in
            
            print(data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

