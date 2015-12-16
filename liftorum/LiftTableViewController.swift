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

    override func viewDidLoad() {
        super.viewDidLoad()
        Lift.getLifts({(response:Response<[Lift], NSError>) in
            switch response.result{
            case .Success:
                self.lifts = response.result.value!
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
                let alert = UIAlertController(
                    title: "Error",
                    message: "Cannot connect to the server.",
                    preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logout(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: "accessToken")
        defaults.setObject(nil, forKey: "userId")
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let initialViewController = storyBoard.instantiateInitialViewController()
        self.presentViewController(initialViewController!, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifts.count
    }
    
    @IBAction func unwindToLiftTable(sender: UIStoryboardSegue) {
        Lift.getLifts({(response:Response<[Lift], NSError>) in
            self.lifts = response.result.value!
            self.tableView.reloadData()
        })
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LiftTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(
            cellIdentifier,
            forIndexPath: indexPath
        ) as! LiftTableViewCell

        let lift = lifts[indexPath.row]
        cell.usernameLabel.text = lift.user.username
        cell.createdAtLabel.text = lift.createdAt.timeAgoSinceNow()
        if lift.comments.count == 0{
            cell.commentsButton.hidden = true
        } else if lift.comments.count == 1{
            let title = String(lift.comments.count) + " Comment"
            cell.commentsButton.setTitle(title, forState: .Normal)
        } else {
            let title = String(lift.comments.count) + " Comments"
            cell.commentsButton.setTitle(title, forState: .Normal)
        }

        let videoUrl = NSURL(string: "https://s3-us-west-2.amazonaws.com/lift-videos-bucket-production/60.MOV")!
        cell.playerView.player.setUrl(videoUrl)
        cell.playerView.player.view.frame = cell.playerView.bounds
        self.addChildViewController(cell.playerView.player)
        cell.playerView.addSubview(cell.playerView.player.view)
        cell.playerView.player.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        cell.playerView.player.didMoveToParentViewController(self)
        
        
        return cell
    }
    
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
