//
//  OpenWeather.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/18/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import Foundation
import ReactiveCocoa

final class OpenWeather {
    
    typealias OpenWeatherCompletionHandler = (AnyObject?, NSError?) -> ()
    
    private let baseURL = "http://api.openweathermap.org/data/2.5"
    
    private let key: String
    private let session: NSURLSession

    init(key: String) {
        self.key = key
        session = NSURLSession.sharedSession()
    }
 
    private func request(endpoint: String, parameters: [String: String], completionHandler: OpenWeatherCompletionHandler? = nil) {
        let url = NSURL(string: "\(baseURL)/\(endpoint)?\(parameters.stringFromHttpParameters())")
        if let url = url {
            let request = NSURLRequest(URL: url)
            session.dataTaskWithRequest(request) {
                (data, urlResponse, error) -> Void in
                if let error = error {
                    completionHandler?(nil, error)
                } else if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        completionHandler?(json, nil)
                    } catch let error as NSError {
                        completionHandler?(nil, error)
                    }
                }
            }.resume()
        }
    }

    func weather(city city: String, completionHandler: OpenWeatherCompletionHandler? = nil) {
        request("weather", parameters: ["q": city, "APPID": key], completionHandler: completionHandler)
    }
    
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}