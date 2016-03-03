//
//  Weather.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/20/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import Foundation

struct Weather {
    
    let city: String
    let temperature: Int
    
    init?(json: [String: AnyObject]) {
        guard let city = json["name"] as? String else { return nil }
        guard let main = json["main"] as? [String: AnyObject] else { return nil }
        guard let temperature = main["temp"] as? Float else { return nil }
        
        self.city = city
        self.temperature = Int((temperature - 273.15) * 1.8 + 32)
    }
    
}