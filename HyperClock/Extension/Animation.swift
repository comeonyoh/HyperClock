//
//  FadeAnimation.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

import pop
import UIKit

protocol FadeAnimation {
    
    typealias FadeAnimationCompletion = (_ isFinished: Bool) -> Void
    
    func fadeIn(_ view: UIView, withDuration duration: Double, withCompletion completion: FadeAnimationCompletion?)
    
    func fadeOut(_ view: UIView, withDuration duration: Double, withCompletion completion: FadeAnimationCompletion?)
}

extension FadeAnimation {

    func fadeIn(_ view: UIView, withDuration duration: Double, withCompletion completion: FadeAnimationCompletion?) {
        
        let fadeInAnim = POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
        
        fadeInAnim?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        fadeInAnim?.fromValue = 0.0
        fadeInAnim?.toValue = 1.0
        fadeInAnim?.duration = duration
        fadeInAnim?.completionBlock = { (anim, completed) in
            
            completion?(completed)
        }

        view.pop_add(fadeInAnim, forKey: "fade.in.animation")
    }
    
    func fadeOut(_ view: UIView, withDuration duration: Double, withCompletion completion: FadeAnimationCompletion?) {
        
        let fadeOutAnim = POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
        
        fadeOutAnim?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        fadeOutAnim?.fromValue = 1.0
        fadeOutAnim?.toValue = 0.0
        fadeOutAnim?.duration = duration
        fadeOutAnim?.completionBlock = { (anim, completed) in
            
            completion?(completed)
        }
       
        view.pop_add(fadeOutAnim, forKey: "fade.out.animation")
    }
}

