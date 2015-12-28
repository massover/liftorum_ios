//
//  LiftTableViewController.swift
//  liftorum
//
//  Created by Voxy on 11/8/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire
import DateTools
import Player

class LiftTableViewController: UITableViewController {
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    var lifts = [Lift]()
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.infiniteScrollIndicatorStyle = .Gray

        tableView.addInfiniteScrollWithHandler { (scrollView) -> Void in
            let tableView = scrollView as! UITableView
            self.loadLifts()
            tableView.reloadData()
            tableView.finishInfiniteScroll()
        }
        
        // http://stackoverflow.com/questions/32558084/multiline-uilabel-within-a-static-uitableviewcell-on-ios-9/32816593#32816593
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.loadLifts()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LiftTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(
            cellIdentifier,
            forIndexPath: indexPath
        ) as! LiftTableViewCell
        
        let lift = lifts[indexPath.row]
        cell.usernameLabel.text = lift.user!.username
        cell.createdAtLabel.text = lift.createdAt!.timeAgoSinceNow()
        cell.textLabel_.text = lift.text
        cell.descriptionLabel.text = lift.description
        cell.commentsButton.setTitle(lift.commentsButtonTitle, forState: .Normal)
        if lift.comments!.count == 0{
            cell.commentsButton.enabled = false
        } else {
            cell.commentsButton.enabled = true
        }
        if let text = lift.text {
            cell.textLabel_.text = text
        } else {
            cell.textLabel_.hidden = true
        }
        cell.newCommentButton.tag = indexPath.row
        cell.playerView.player.setUrl(NSURL(string:lift.video!.url!)!)
        self.addChildViewController(cell.playerView.player)
        cell.playerView.player.didMoveToParentViewController(self)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToCommentTableViewController" {
            let navigationController = segue.destinationViewController as? UINavigationController
            let commentTableViewController = navigationController?.topViewController as? CommentTableViewController
            commentTableViewController!.lift = lifts[sender!.tag]
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "accessToken")
        defaults.setObject(nil, forKey: "userId")
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyBoard.instantiateInitialViewController()
        self.presentViewController(initialViewController!, animated: true, completion: nil)
    }
    
    @IBAction func unwindToLiftTable(sender: UIStoryboardSegue) {
        self.lifts = []
        self.currentPage = 1
        self.loadLifts()
    }
    
    @IBAction func refresh(sender: AnyObject) {
        self.lifts = []
        self.currentPage = 1
        self.loadLifts()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func loadLifts() {
        Lift.getLifts(self.currentPage, completionHandler: {(response:Response<[Lift], NSError>) in
            switch response.result{
            case .Success:
                self.lifts += response.result.value!
                self.currentPage += 1
                self.tableView.reloadData()
            case .Failure(let error):
                print(response)
//                print(error)
                let alert = UIAlertController(
                    title: "Error",
                    message: "Cannot connect to the server.",
                    preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        })
    }
    
}
