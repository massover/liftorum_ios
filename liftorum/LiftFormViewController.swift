//
//  LiftFormViewController.swift
//  liftorum
//
//  Created by Voxy on 12/3/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class LiftFormViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            //print(liftPickerView.getSelectedLiftName())
        }
        
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
