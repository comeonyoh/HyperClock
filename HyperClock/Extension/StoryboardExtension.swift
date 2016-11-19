//
//  StoryboardExtension.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardManager: String {
    
    case Main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
    }
    
}
