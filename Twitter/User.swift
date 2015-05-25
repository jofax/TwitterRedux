//
//  User.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/24/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var screenname: String
    var profileImageUrl: NSURL
    var tagline: String
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        self.name = dictionary["name"] as! String
        self.screenname = dictionary["screen_name"] as! String
        self.profileImageUrl = NSURL(string: dictionary["profile_image_url"] as! String)!
        self.tagline = dictionary["description"] as! String
    }
}
