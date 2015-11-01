//
//  ViewController.swift
//  liftorum
//
//  Created by Voxy on 11/1/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var repsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitLift(sender: UIButton) {
        print(repsTextField?.text)
        print(weightTextField?.text)
    }
    


}

