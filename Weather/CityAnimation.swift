//
//  CityAnimation.swift
//  Weather
//
//  Created by Ayush Saraswat on 2/20/16.
//  Copyright © 2016 Udacity, Inc. All rights reserved.
//

import UIKit

class CityAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum CityAnimationTransitionMode: Int {
        case Present, Pop
    }
    
    var transitionMode: CityAnimationTransitionMode = .Present
    let scaleFactor: CGFloat = 0.05
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView() else {
            transitionContext.completeTransition(true)
            return
        }
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let duration = self.transitionDuration(transitionContext)
    
        switch transitionMode {
        case .Present:
            toView.frame = CGRect(x: containerView.bounds.size.width, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
            containerView.addSubview(toView)
            
            let topBottomMargin = containerView.bounds.size.height * self.scaleFactor
            let sideMargin = containerView.bounds.size.width * self.scaleFactor
            containerView.addSubview(fromView)
            
            containerView.bringSubviewToFront(toView)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.frame = fromView.frame.addMargin(top: topBottomMargin, left: sideMargin, bottom: topBottomMargin, right: sideMargin)
                toView.frame = containerView.frame
                }) { (_) in
                    transitionContext.completeTransition(true)
            }
        case .Pop:
            containerView.addSubview(toView)
            let topBottomMargin = containerView.bounds.size.height * self.scaleFactor
            let sideMargin = containerView.bounds.size.width * self.scaleFactor
            toView.frame = containerView.bounds.addMargin(top: topBottomMargin, left: sideMargin, bottom: topBottomMargin, right: sideMargin)
            
            containerView.addSubview(fromView)
            containerView.bringSubviewToFront(fromView)
            
            UIView.animateWithDuration(duration, animations: {
                fromView.frame = CGRect(x: containerView.bounds.size.width, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
                toView.frame = containerView.frame
                }) { (_) in
                    transitionContext.completeTransition(true)
            }
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
}