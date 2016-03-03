//
//  CityCell.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/21/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import UIKit

final class CityCell: UICollectionViewCell {
    
    @IBOutlet var cityLabel: UILabel?

    func configureWithCityName(name: String) {
        cityLabel?.text = name
        
        // Rounding
        layer.cornerRadius = bounds.size.width / 2

        // Border
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blackColor().CGColor
        
        // Shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.4
    }
    
}