//
//  Animation.swift
//  SOSideMenu
//
//  Created by Hitesh on 11/16/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit

class Animation: NSObject, UIViewControllerAnimatedTransitioning {

    let isPresenting :Bool
    let duration :NSTimeInterval = 0.5
    
    let menuWidth : CGFloat = 0.76
    let percentThreshold:CGFloat = 0.35
    let viewTag = 007
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    
    // ---- UIViewControllerAnimatedTransitioning methods
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    
    // ---- Helper methods
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        // replace main view with snapshot
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        snapshot.tag = viewTag
        snapshot.userInteractionEnabled = false
        snapshot.layer.shadowOpacity = 1.0
        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.hidden = true
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                snapshot.center.x += UIScreen.mainScreen().bounds.width * self.menuWidth
            },
            completion: { _ in
                fromVC.view.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        )
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
            else {
                return
        }
        let snapshot = containerView.viewWithTag(viewTag)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            animations: {
                snapshot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.mainScreen().bounds.size)
            },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled()
                if didTransitionComplete {
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot?.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
            }
        )
    }
}


