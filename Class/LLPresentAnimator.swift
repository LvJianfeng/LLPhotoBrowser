//
//  LLPresentAnimator.swift
//  LLPhotoBrowser
//
//  Created by LvJianfeng on 2017/11/16.
//  Copyright © 2017年 LvJianfeng. All rights reserved.
//

import UIKit
import Foundation

class LLPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentView = transitionContext.view(forKey: .to)
        transitionContext.containerView.addSubview(presentView!)
        
        presentView?.backgroundColor = UIColor.black
        
        UIView.animate(withDuration: 0.2, animations: {
            presentView?.alpha = 1
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

class LLDismissAnimator: NSObject,  UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)
        
        UIView.animate(withDuration: 0.2, animations: {
            fromView!.alpha = 0
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}
