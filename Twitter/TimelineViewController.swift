//
//  TimelineViewController.swift
//  Twitter
//
//  Created by Venkata Vijay on 5/24/15.
//  Copyright (c) 2015 Venkata Vijay. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var tweets: [NSDictionary]!
    var refreshControl:UIRefreshControl!
    var composeCalled:Bool = false
    var timelineType = "home_timeline"
    
    @IBOutlet weak var composeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        TwitterClient.sharedInstance.GET("1.1/statuses/\(timelineType).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println(response)
                self.tweets = response as! [NSDictionary]
                //println(self.tweets[0])
                self.tableView.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                println(error)
        })
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell") as! TimelineTableViewCell
        
        cell.tweet = self.tweets?[indexPath.row]
        return cell
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.GET("1.1/statuses/\(timelineType).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            self.tweets = response as! [NSDictionary]
            self.tableView.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
        })
        
        delay(2, closure: {
            println("refresh done")
            self.refreshControl.endRefreshing()
        })
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBAction func onComposeTap(sender: AnyObject) {
        println("Compose tapped")
        composeCalled = true
    }

    
    @IBAction func onUserTap(sender: UITapGestureRecognizer) {
        println("User Tapped")
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if composeCalled {
            composeCalled = false
        } else {
            var vc = segue.destinationViewController as! TweetViewController
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            var thisTweet = self.tweets?[indexPath!.row]
            
            let tweet = thisTweet!["text"] as! String
            let name = thisTweet!["user"]!["name"] as! String
            let screen_name = "@" + (thisTweet!["user"]!["screen_name"] as! String)
            let imageURL = thisTweet!["user"]!["profile_image_url_https"] as! String
            
            let image = NSURL(string: imageURL)
            
            vc.name = name
            
            vc.handle = screen_name
            vc.tweet = tweet
            vc.image = image!
            vc.id = thisTweet!["id_str"] as! String
            
            /*println(thisTweet!)
            println(indexPath!.row)
            
            println("Trigger") */
        }

    }

}
