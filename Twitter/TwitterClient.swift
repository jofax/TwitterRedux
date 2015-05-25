//
//  TwitterClient.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/22/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

let twitterConsumerKey = "0IDYHyJyxOmaBXhAedekZcT9P"
let twitterConsumerSecret = "jTWsUV1YEKI3FEqFgRZV4bqAugjOuvyx9RYzbLwmohdf1wVafI"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
   
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
