//
//  Transitions.swift
//  RKPickerView
//
//  Created by Rayehe on 7/3/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

class transitionManager : NSObject , UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented.isKind(of: RKPickerViewController.classForCoder()) {
            return pickerTransition()
        }
        
        return nil
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed.isKind(of: RKPickerViewController.classForCoder()) {
            return dismissPickerTransition()
        }
        return nil
    }
}

internal class pickerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let animationDuration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return pickerTransition.animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) as? RKPickerViewController else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.view)
        let snapShot = fromVC.view.snapshotView(afterScreenUpdates: true)
        containerView.addSubview(snapShot!)
        
        let dimView = UIView(frame: transitionContext.finalFrame(for: toVC))
        dimView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        dimView.alpha = 0.0
        dimView.tag = 101
        dimView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: toVC, action: #selector(toVC.dismissPickerView))
        toVC.gestureHolderView.isUserInteractionEnabled = true
        toVC.gestureHolderView.addGestureRecognizer(tapGesture)
        
        containerView.addSubview(dimView)
        
        containerView.addSubview(toVC.view)
        toVC.view.isUserInteractionEnabled = true
        toVC.view.alpha = 0.0
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.layoutIfNeeded()
        
        let scaleTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        let translateTransform = CGAffineTransform(translationX: 0.0, y: 30.0)
        toVC.view.transform = translateTransform.concatenating(scaleTransform)
        
        UIView.animate(withDuration: pickerTransition.animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        
                        dimView.alpha = 1.0
                        toVC.view.alpha = 1.0
                        toVC.view.transform = .identity
                        toVC.view.layoutIfNeeded()
                        
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }
}

internal class dismissPickerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    static let animationDuration = 1.0
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return dismissPickerTransition.animationDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let _ = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        toVC.view.alpha = 0.0
        containerView.addSubview(toVC.view)
        
        var dimView = UIView()
        for subview in toVC.view.subviews {
            if subview.tag == 101 {
                dimView = subview
            }
        }
        
        UIView.animate(withDuration: dismissPickerTransition.animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        
                        dimView.alpha = 0.0
                        toVC.view.alpha = 1.0
                        
                        
        }) { (finished) in
            
            transitionContext.completeTransition(true)
        }
        
    }
}
