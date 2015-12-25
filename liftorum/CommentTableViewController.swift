//
//  CommentTableViewController.swift
//  liftorum
//
//  Created by Voxy on 12/20/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class CommentTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var logoutButton: UIBarButtonItem!
    @IBOutlet var newCommentTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var lift: Lift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // http://stackoverflow.com/questions/32558084/multiline-uilabel-within-a-static-uitableviewcell-on-ios-9/32816593#32816593
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension
        self.newCommentTextField.delegate = self
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CommentTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(
            cellIdentifier,
            forIndexPath: indexPath
            ) as! CommentTableViewCell
        let comment = lift.comments[indexPath.row]
        cell.commentTextLabel.text = comment.text
        cell.usernameLabel.text = comment.user.username
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
