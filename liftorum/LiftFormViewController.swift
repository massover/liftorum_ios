//
//  LiftFormViewController.swift
//  liftorum
//
//  Created by Voxy on 12/3/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class LiftFormViewController: UIViewController{
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var repsTextField: UITextField!
    
    @IBOutlet var commentTextView: UITextView!
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        commentTextView.layer.borderWidth = 1.0
        commentTextView.layer.cornerRadius = 5.0
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("keyboardWillShow:"),
            name: UIKeyboardWillShowNotification,
            object: nil
        )
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("keyboardWillHide:"),
            name: UIKeyboardWillHideNotification,
            object: nil
        )
        print(video?.id)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if commentTextView.isFirstResponder() {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if commentTextView.isFirstResponder() {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @IBAction func textFieldDidChange(sender: AnyObject) {
        print("hello world!")
        if weightTextField.text != "" && repsTextField.text != ""{
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        weightTextField.resignFirstResponder()
        repsTextField.resignFirstResponder()
        commentTextView.resignFirstResponder()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //print(liftPickerView.getSelectedLiftName())
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
