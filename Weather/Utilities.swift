//
//  Utilities.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/22/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import UIKit

func performOnMainThread(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue()) {
        block()
    }
}

extension CGRect {
    
    func addMargin(top top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CGRect {
        let marginRect = CGRect(x: origin.x + left, y: origin.y + top, width: size.width - left - right, height: size.height - top - bottom)
        return marginRect
    }
    
}