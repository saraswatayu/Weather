//
//  CityAnimation.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/20/16.
//  Copyright © 2016 SwatTech, LLC. All rights reserved.
//

import UIKit

class CityAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum CityAnimationTransitionMode: Int {
        case Present, Dismiss
    }
    
    var transitionMode: CityAnimationTransitionMode = .Present
    var fromFrame: CGRect?
    var toFrame: CGRect?
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        let animationDuration = self .transitionDuration(transitionContext)
        
        // add blurred background to the view
        let fromViewFrame = fromViewController.view.frame
        
        UIGraphicsBeginImageContext(fromViewFrame.size)
        fromViewController.view.drawViewHierarchyInRect(fromViewFrame, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.frame = fromFrame!
        containerView.addSubview(snapshotView)
        
        toViewController.view.alpha = 0.0
        containerView.addSubview(toViewController.view)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: UIViewAnimationOptions.AllowUserInteraction,
            animations: { () -> Void in
                snapshotView.frame = fromViewController.view.frame
            }, completion: { (finished) -> Void in
                snapshotView.removeFromSuperview()
                toViewController.view.alpha = 1.0
                
                transitionContext.completeTransition(finished)
        })
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
}