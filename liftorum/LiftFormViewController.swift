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
    
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(video?.id)
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //print(liftPickerView.getSelectedLiftName())
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
