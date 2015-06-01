//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/31/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var screenName:String!
    var id:String!
    var userDetails:NSDictionary!

    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var params: NSDictionary = [
            //"user_id": id,
            "screen_name": screenName
        ]
        
        TwitterClient.sharedInstance.GET("1.1/users/show.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("Fetched user details")
            
                self.userDetails = response as! NSDictionary
            
                let tweetsCount = self.userDetails["statuses_count"] as! Int
                self.tweetsLabel.text = "\(tweetsCount)"
            
                let followingCount = self.userDetails["friends_count"] as! Int
                self.followingLabel.text = "\(followingCount)"
            
                let followersCount = self.userDetails["followers_count"] as! Int
                self.followersLabel.text = "\(followersCount)"
            
                let profileImage = NSURL(string: self.userDetails["profile_image_url"] as! String)
                self.profileImageView.setImageWithURL(profileImage)
            
                let bannerImage = NSURL(string: self.userDetails["profile_background_image_url"] as! String)
                self.headerImageView.setImageWithURL(bannerImage)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed")
                
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
