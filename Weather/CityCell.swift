//
//  CityCell.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/21/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import UIKit

final class CityCell: UICollectionViewCell {
    
    @IBOutlet var cityLabel: UILabel?

    func configureWithCityName(name: String) {
        cityLabel?.text = name
        
        layer.cornerRadius = bounds.size.width / 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blackColor().CGColor
    }
    
}