//
//  UIViewExtension.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import UIKit

/**
 * This can be used when UIView can be loaded from XIB
 */

protocol LoadFromXib {
    func loadXib(_ view: UIView, withXibName name: String, withClass anyClass: AnyClass)
}

extension LoadFromXib {
    
    func loadXib(_ view: UIView, withXibName name: String, withClass anyClass: AnyClass) {
     
        let xibView =
            Bundle.init(for: anyClass).loadNibNamed(name, owner: self, options: nil)?.first as! UIView
        
        xibView.frame = view.bounds
        
        view.addSubview(xibView)
    }
    
}
