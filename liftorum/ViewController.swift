//
//  ViewController.swift
//  liftorum
//
//  Created by Voxy on 11/1/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

class ViewController:
    UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    var pickerDataSource = ["Squat", "Bench", "Deadlift"]
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var liftPickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectVideoFromLibrary(sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
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

