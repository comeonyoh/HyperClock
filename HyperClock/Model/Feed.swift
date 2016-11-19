//
//  Feed.swift
//  HyperClock
//
//  Created by KimJungSu on 11/19/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import AlamofireImage

class Feed {
    
    var title: String?
    
    let imageUrl: String!
    
    var mediaImage: UIImage?

    init(withDictionary dictionary: Dictionary<String, JSON>?) {
        self.imageUrl = dictionary?["media"]?.dictionary?["m"]?.string
    }
    
}

extension Feed {
 
    typealias FeedImageHandler = (_ isSuccess: Bool) -> Void
    
    func requestFetchImageUrl(withHandler handler: FeedImageHandler?) {

        guard self.mediaImage == nil else {
            
            handler?(true)
            
            return
        }
        
        let config = URLSessionConfiguration.default
        
        config.timeoutIntervalForRequest = 5.0
        config.timeoutIntervalForResource = 5.0
        
        _ = Alamofire.SessionManager(configuration: config)
        
        Alamofire.request(self.imageUrl).responseImage {
            
            if $0.result.error == nil {

                self.mediaImage = $0.result.value
                
                handler?(true)
            }
            else {
                handler?(false)
            }
        }
    }

}
