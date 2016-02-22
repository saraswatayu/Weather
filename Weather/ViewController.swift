//
//  ViewController.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/18/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    private var openWeather: OpenWeather {
        return OpenWeather.sharedInstance()
    }

    @IBOutlet var temperatureLabel: UILabel?
    @IBOutlet var cityLabel: UILabel?
    
    let animation = BubbleTransition()
    
    var selectedCity = "New York, NY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        reloadWeather()
    }
    
    func reloadWeather() {
        openWeather.weather(city: selectedCity) {
            (weather) -> Void in
            guard let weather = weather else { return }
            
            self.performOnMainThread() {
                self.temperatureLabel?.text = "\(weather.temperature)° F"
                self.cityLabel?.text = weather.city
            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animation.transitionMode = .Pop
        return animation
    }
    
}

extension UIViewController {
    
    func performOnMainThread(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            block()
        }
    }
    
}