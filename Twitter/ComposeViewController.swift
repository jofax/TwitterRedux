//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/24/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var handleTextLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tweetTextView.delegate = self
        self.tweetTextView.becomeFirstResponder()
        
        let user = NSUserDefaults.standardUserDefaults().objectForKey("userData") as! NSData
        
        var dictionary = NSJSONSerialization.JSONObjectWithData(user, options: nil, error: nil) as! NSDictionary
        
        nameTextLabel.text = dictionary["name"] as? String
        handleTextLabel.text = "@" + (dictionary["screen_name"] as! String)
        let imageURL = NSURL(string: dictionary["profile_image_url_https"] as! String)
        
        profileImageView.setImageWithURL(imageURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func onSendTweet(sender: AnyObject) {
        let status = self.tweetTextView.text
        if count(status) <= 0 {
            return
        }
        
        var params: NSDictionary = [
            "status": status
        ]
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println("Tweeted Successfully")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed")
                
        }
        
        self.tweetTextView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancelTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
