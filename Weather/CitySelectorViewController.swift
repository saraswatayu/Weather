//
//  CitySelectorViewController.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/20/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import UIKit

class CitySelectorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    let animation = BubbleTransition()
    let cities = ["San Francisco, CA", "New York, NY", "Los Angeles, CA", "Miami, FL", "Dallas, TX", "Boston, MA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let side = (view.bounds.size.width - 40) / 3
        let top = view.bounds.size.height - ((side + 10) * CGFloat(cities.count) / 3) - 20
        layout.sectionInset = UIEdgeInsets(top: top / 2, left: 10.0, bottom: top / 2, right: 10.0)
        collectionView.collectionViewLayout = layout
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        cell.configureWithCityName(cities[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let side = (view.bounds.size.width - 40) / 3
        return CGSize(width: side, height: side)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CityCell
        
        
        
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        let attributesFrame = attributes?.frame
        let frameToOpenFrom = collectionView.convertRect(attributesFrame!, toView: collectionView.superview)
        animation.startingPoint = CGPoint(x: (frameToOpenFrom.origin.x + frameToOpenFrom.size.width) / 2, y: (frameToOpenFrom.origin.y + frameToOpenFrom.size.height) / 2)

        performSegueWithIdentifier("WeatherDetail", sender: indexPath)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    
}

extension CitySelectorViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animation.transitionMode = .Present
        return animation
    }
    
}