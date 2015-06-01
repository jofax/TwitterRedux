//
//  TweetViewController.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/24/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var handleTextLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var name:String!
    var handle:String!
    var tweet:String!
    var image:NSURL!
    var id:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextLabel.text = name
        handleTextLabel.text = handle
        tweetTextLabel.text = tweet
        profileImageView.setImageWithURL(image)
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.profileImageView.userInteractionEnabled = true
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("onImageTap:"))
        self.profileImageView.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweetTap(sender: AnyObject) {
        var url = "1.1/statuses/retweet/" + self.id + ".json"
        TwitterClient.sharedInstance.POST(url, parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("Retweeted successfully")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error posting status update")
        }
    }

    @IBAction func onFavouriteTap(sender: AnyObject) {
        var url = "1.1/favorites/create.json?id=" + self.id
        TwitterClient.sharedInstance.POST(url, parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Favourited successfully")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error posting status update")
        }
    }
    
    @IBAction func onReplyTap(sender: AnyObject) {
        let reply = "RT: @" + self.handle + self.tweet
        var params = [
            "status": reply,
            "in_reply_to_status_id" : id
        ]
        
        performSegueWithIdentifier("replySegue", sender: self)
    }
    
    
    @IBAction func onImageTap(sender: AnyObject) {
        println("Image Tapped")
        performSegueWithIdentifier("showProfileSegue", sender: self)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProfileViewController
        vc.id = self.id
        vc.screenName = self.handle
    }

}
