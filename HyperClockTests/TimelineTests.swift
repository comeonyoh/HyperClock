//
//  TimelineTests.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import XCTest
@testable import HyperClock

class TimelineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIncreaseCurrentIndex() {
        
        let manager = Timeline.init()
        
        XCTAssertEqual(manager.getCurrentFeedIndex(), 0)
        
        manager.increaseCurrentIndex()
        
        XCTAssertEqual(manager.getCurrentFeedIndex(), 1)
        
    }
    
    func testLoadFeeds() {
        
        let exp = expectation(description: "test_load_feeds")
        
        let timeline = Timeline.init()
        
        timeline.requestTimelineFeeds { (isSuesss, error) in
        
            if isSuesss == true && error == nil {
                exp.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 15.0, handler: {
            XCTAssertNil($0)
        })
    }
    
    
}
