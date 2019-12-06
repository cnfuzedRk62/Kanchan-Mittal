//  SlideTransition.swift
//  SlideInMenu
//  Created by Mandeep Singh on 17/04/19.
//  Copyright © 2019 Mandeep Singh. All rights reserved.

import UIKit

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = false
    let dimmView = UIView()
    var transitionContext : UIViewControllerContextTransitioning?
    var maximum_x = CGFloat()

    override init() {
        super.init()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickOnTapGesture))
        tapGesture.numberOfTapsRequired = 1
        dimmView.addGestureRecognizer(tapGesture)
        self.maximum_x = dimmView.frame.maxX
    }

    //MARK: Set Blur Effect Alpha
    func setAlphaOfBlurView(origin : CGFloat)
    {
        if origin <= maximum_x {
            dimmView.alpha = 0.8
        } else if origin > self.sideMenu!.view.frame.size.width*0.5 {
            dimmView.alpha = 0.5
        } else if origin > self.sideMenu!.view.frame.size.width*0.3 {
            dimmView.alpha = 0.3
        }
        
        ///Reload view
        dimmView.setNeedsDisplay()

    }
    
    var sideMenu : menuController? {
        get {
            guard let context = self.transitionContext else {return nil}
            guard let toViewController = context.viewController(forKey: .to) as? menuController else {
                return nil
            }
            return toViewController
        }
    }
    
    @objc func clickOnTapGesture() {
        guard let toViewController = self.sideMenu  else {return}
        toViewController.dismissController()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        sideMenu?.blurView = self.dimmView
        
        if isPresenting {
            //dimm View
            dimmView.backgroundColor = .black
            dimmView.alpha = 0.0
            containerView.addSubview(dimmView)
            dimmView.frame = containerView.bounds
            
            //Add controller to container
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        let transform = {
            self.dimmView.alpha = 0.7
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        let identity = {
            self.dimmView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let cancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!cancelled)
        }
    }
    
}
