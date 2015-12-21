//
//  CommentTableViewController.swift
//  liftorum
//
//  Created by Voxy on 12/20/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class CommentTableViewController: UITableViewController {
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    var lift: Lift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLift()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lift.comments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CommentTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(
            cellIdentifier,
            forIndexPath: indexPath
            ) as! CommentTableViewCell
        let comment = lift.comments[indexPath.row]
        cell.commentTextLabel.numberOfLines = 0
        cell.commentTextLabel.lineBreakMode = .ByWordWrapping
        cell.commentTextLabel.text = "this is a lot of text. I want to see how it renders. This is a lot more text. What happens now??"
        cell.commentTextLabel.sizeToFit()
        cell.usernameLabel.text = "Username"
        cell.createdAtLabel.text = comment.createdAt.timeAgoSinceNow()
        return cell
    }
    
    @IBAction func refresh(sender: AnyObject) {
        self.lift = nil
        self.loadLift()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func loadLift() {
        Lift.getLift(self.lift.id, completionHandler: {(response:Response<Lift, NSError>) in
            switch response.result{
            case .Success:
                self.lift = response.result.value!
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
    }
}
