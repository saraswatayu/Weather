//
//  OpenWeather.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/18/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import Foundation

final class OpenWeather {
    
    typealias OpenWeatherRequestCompletionHandler = ([String: AnyObject]?, NSError?) -> ()
    typealias OpenWeatherCompletionHandler = (Weather?) -> ()
    
    private let baseURL = "http://api.openweathermap.org/data/2.5"
    
    private var key: String {
        return Constants.OpenWeatherAPIKey
    }
 
    private func request(endpoint: String, parameters: [String: String], completionHandler: OpenWeatherRequestCompletionHandler? = nil) {
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "\(baseURL)/\(endpoint)?APPID=\(key)&\(parameters.stringFromHttpParameters())")
        
        if let url = url {
            let request = NSURLRequest(URL: url)
            let dataTask = session.dataTaskWithRequest(request) {
                (data, urlResponse, error) -> Void in
                if let error = error {
                    completionHandler?(nil, error)
                } else if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]
                        completionHandler?(json, nil)
                    } catch let error as NSError {
                        completionHandler?(nil, error)
                    }
                }
            }
            
            dataTask.resume()
        }
        
    }

    func weather(city city: String, completionHandler: OpenWeatherCompletionHandler? = nil) {
        request("weather", parameters: ["q": city]) {
            (json, error) -> Void in
            if let _ = error {
                completionHandler?(nil)
            } else if let json = json {
                let weather = Weather(json: json)
                completionHandler?(weather)
            }
        }
    }
    
    static func sharedInstance() -> OpenWeather {
        return OpenWeather()
    }
    
}

extension String {
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}