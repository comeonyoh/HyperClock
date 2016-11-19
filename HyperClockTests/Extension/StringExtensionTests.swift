//
//  StringExtensionTests.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import XCTest
@testable import HyperClock

class StringExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStringLength() {
        
        let str = "Welcome to Korea"
        
        XCTAssertEqual(str.length(), 16)
        
        let emptyStr = ""
        
        XCTAssertEqual(emptyStr.length(), 0)
    }
    
    func testSubstring() {
        
        let str = "Hello Tiger"
        
        XCTAssertEqual(str.substring(withRange: Range.init(start: 0, length: 5)), "Hello")
        XCTAssertEqual(str.substring(withRange: Range.init(start: 0, length: 5)).length(), 5)
        
        XCTAssertEqual(str.substring(5), "Hello")
        XCTAssertEqual(str.substring(start: 6), "Tiger")
        
    }
}
