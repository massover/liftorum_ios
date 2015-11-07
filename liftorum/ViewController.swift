//
//  ViewController.swift
//  liftorum
//
//  Created by Voxy on 11/1/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerDataSource = ["Squat", "Bench", "Deadlift"]
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var liftPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liftPickerView.dataSource = self
        self.liftPickerView.delegate = self
        self.liftPickerView.reloadAllComponents()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    @IBAction func submitLift(sender: UIButton) {
        let row = liftPickerView.selectedRowInComponent(0)
        let parameters = [
            "weight": weightTextField.text!,
            "reps": repsTextField.text!,
            "user_id": 1,
            "name": pickerDataSource[row].lowercaseString
        ]
        Alamofire.request(
            .POST,
            "http://localhost:5000/api/lift",
            parameters: parameters as? [String : AnyObject],
            encoding: .JSON
        ).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

    }
    


}

