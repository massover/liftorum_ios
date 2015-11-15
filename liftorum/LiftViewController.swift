//
//  ViewController.swift
//  liftorum
//
//  Created by Voxy on 11/1/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire
import MobileCoreServices

class LiftViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var liftPickerView: LiftPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            print(liftPickerView.getSelectedLiftName())
        }
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func selectVideoFromLibrary(sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePickerController.sourceType = .Camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.delegate = self
            presentViewController(imagePickerController, animated: true, completion: nil)
        }
        else {
            print("No camera available")
        }
        

    }

}

