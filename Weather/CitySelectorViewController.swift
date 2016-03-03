//
//  CitySelectorViewController.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/20/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import UIKit

class CitySelectorViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    let cities = ["San Francisco", "New York", "Los Angeles", "Miami", "Dallas", "Boston"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let side = (view.frame.size.width - 60) / 3
        let top = view.frame.size.height - ((side + 15) * CGFloat(cities.count) / 3) - 30
        layout.sectionInset = UIEdgeInsets(top: top / 2, left: 15.0, bottom: top / 2, right: 15.0)
        collectionView.collectionViewLayout = layout
        
        navigationController?.delegate = self
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
        let side = (view.frame.size.width - 60) / 3
        return CGSize(width: side, height: side)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("WeatherDetail", sender: indexPath)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        guard let controller = segue.destinationViewController as? WeatherViewController else { return }
        controller.selectedCity = cities[(sender as! NSIndexPath).row]
    }
    
}

extension CitySelectorViewController: UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = CityAnimation()
        if fromVC is CitySelectorViewController {
            animation.transitionMode = .Present
        } else {
            animation.transitionMode = .Pop
        }
        
        return animation
    }

}