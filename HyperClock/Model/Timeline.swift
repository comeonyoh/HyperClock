//
//  Timeline.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Timeline {
 
    /**
     * this variable indicates current feed`s index that will be displayed in view
     */
    fileprivate var currentFeedIndex = 0
    
    fileprivate var feeds: Array<Feed> = [Feed]()

    fileprivate let serviceAPI = "https://api.flickr.com/services/feeds/photos_public.gne?format=json"
    
    func feedsCount() -> Int {
        return self.feeds.count
    }

    func increaseCurrentIndex() {
        currentFeedIndex += 1
    }

    func getCurrentFeedIndex() -> Int {
        return self.currentFeedIndex
    }
    
    func feedAtCurrentIndex() -> Feed? {
        
        if self.currentFeedIndex < self.feeds.count {
            
            if self.loadMoreFeeds() == true {
                
                // load more feed
                self.requestTimelineFeeds(withHandler: nil)
            }
            
            self.nextTwoFeedsImageLoad(self.currentFeedIndex)
            
            return self.feeds[self.currentFeedIndex]
        }
        
        return nil
    }
    
}

/**
 * Extension for networking API
 */

extension Timeline {

    typealias TimelineRequestHandler = (_ isSuccess: Bool, _ error: Error?) -> Void

    func requestTimelineFeeds(withHandler handler: TimelineRequestHandler?) {

        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 10.0

        Alamofire.request(serviceAPI).responseString { response in
            
            if response.result.error == nil, let resultString = response.result.value {
                
                self.parseFlickrFeeds(resultString)
                
                handler?(true, nil)
            }
            else{
                handler?(false, response.result.error)
            }
        }
    }
    
}

/**
 * Extension for private methods
 */

extension Timeline {
    
    fileprivate func loadMoreFeeds() -> Bool {
        
        //  if the count of feed is less than '20', request load more feed
        if self.feeds.count < 20 {
            return true
        }
        
        //  iff the current index is 10 less than the total number
        //  request load more feed
        if self.currentFeedIndex == self.feeds.count - 10 {
            return true
        }
        
        return false
    }
    
    fileprivate func parseFlickrFeeds(_ resultString: String) {
        
        let prefix = "jsonFlickrFeed("
        let suffix = ")"
        
        let items = "items"

        if resultString.hasPrefix(prefix) && resultString.hasSuffix(suffix) {
            
            let refinedString =
                resultString.substring(withRange: Range(start: prefix.length(),
                                                       length: resultString.length() - prefix.length() - suffix.length()))

            let json = JSON.init(data: refinedString.data(using: .utf8)!)

            for item in json[items].enumerated() {

                let feed = Feed.init(withDictionary: item.element.1.dictionary)

                self.feeds.append(feed)
            }
        }
    }
    
    fileprivate func nextTwoFeedsImageLoad(_ index: Int) {
        
        //  Next feed`s image load
        if index + 1 < self.feedsCount() {
            
            let nextFeed = self.feeds[index + 1]
            
            nextFeed.requestFetchImageUrl(withHandler: nil)
        }
        
        //  Next next feed`s image load
        if index + 2 < self.feedsCount() {
            
            let nextNextFeed = self.feeds[index + 2]
            
            nextNextFeed.requestFetchImageUrl(withHandler: nil)
        }
    }
}







