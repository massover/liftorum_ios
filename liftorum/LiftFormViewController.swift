//
//  LiftFormViewController.swift
//  liftorum
//
//  Created by Voxy on 12/3/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class LiftFormViewController: UIViewController{
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var repsTextField: UITextField!
    @IBOutlet var liftPickerView: LiftPickerView!
    @IBOutlet var commentTextView: UITextView!
    
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        commentTextView.layer.borderWidth = 1.0
        commentTextView.layer.cornerRadius = 5.0
    }
    
    @IBAction func textFieldDidChange(sender: AnyObject) {
        if weightTextField.text!.isEmpty && repsTextField.text!.isEmpty {
            saveButton.enabled = false
        } else {
            saveButton.enabled = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        weightTextField.resignFirstResponder()
        repsTextField.resignFirstResponder()
        commentTextView.resignFirstResponder()
    }
    
    @IBAction func Save(sender: AnyObject) {
        let completionHandler = { (response:Response<Lift, NSError>) in
            switch response.result{
            case .Success:
                self.performSegueWithIdentifier("UnwindToLiftTable", sender: self)
            case .Failure(let error):
                print(error)
            }
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        if commentTextView.text.isEmpty {
            Lift.create(
                liftPickerView.getSelectedLiftName(),
                weight: Int(weightTextField.text!)!,
                reps: Int(repsTextField.text!)!,
                videoId: video.id,
                userId: Int(defaults.stringForKey("userId")!)!,
                completionHandler: completionHandler
            )
            
        } else {
            Lift.create(
                liftPickerView.getSelectedLiftName(),
                weight: Int(weightTextField.text!)!,
                reps: Int(repsTextField.text!)!,
                videoId: video.id,
                userId: Int(defaults.stringForKey("userId")!)!,
                text: commentTextView.text,
                completionHandler: completionHandler
            )
        }
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
