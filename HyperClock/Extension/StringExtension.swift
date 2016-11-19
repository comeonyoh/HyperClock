//
//  StringExtension.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

struct Range {
    
    var start = 0
    var length = 0
}

extension String {
    
    /**
     * return the length of string
     */
    
    func length() -> Int {
        return self.characters.count
    }
    
    /**
     * substring methods.
     */
    
    func substring(_ to: Int) -> String {
        return self.substring(withRange: Range.init(start: 0, length: to))
    }
    
    func substring(start from: Int) -> String {
        return self.substring(withRange: Range.init(start: from, length: self.length() - from))
    }
    
    func substring(withRange range: Range) -> String {
        
        if range.start < 0 || range.length < 0 {
            return self
        }
        
        let subrange = self.index(self.startIndex, offsetBy: range.start)..<self.index(self.startIndex, offsetBy: range.start + range.length)
        
        return self.substring(with: subrange)
    }
    
    func substring(start from: Int, withLength length: Int) -> String {
        return self.substring(withRange: Range.init(start: from, length: from + length))
    }
    
}
