//
//  TimelineTableViewCell.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/24/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var handleTextLabel: UILabel!
    @IBOutlet weak var timeTextTable: UILabel!
    
    var tweet: NSDictionary! {
        didSet {
            tweetTextLabel.text = tweet?["text"] as? String
            let profileImageUrl = tweet?["user"]?["profile_image_url_https"] as? String ?? "http://pbs.twimg.com/profile_images/2284174872/7df3h38zabcvjylnyfe3_normal.png"
            
            let imageURL = NSURL(string: profileImageUrl)
            profileImageView.setImageWithURL(imageURL)
            userNameTextLabel.text = tweet?["user"]?["name"] as? String
            var handleName = tweet?["user"]?["screen_name"] as? String ?? ""
            handleTextLabel.text = "@\(handleName)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
