//
//  CALayerExtension.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func setBorderBackgroundColor(_ color: UIColor) {
        self.borderColor = color.cgColor
    }
}
