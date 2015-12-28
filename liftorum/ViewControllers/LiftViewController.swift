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
import Player

class LiftViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var takeVideoButton: UIButton!
    @IBOutlet weak var selectVideoButton: UIButton!
    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.player.view.frame = playerView.bounds
        self.addChildViewController(playerView.player)
        playerView.addSubview(playerView.player.view)
        playerView.player.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        playerView.player.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func takeVideo(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as String]
        cameraController.allowsEditing = false
        cameraController.delegate = self
        presentViewController(cameraController, animated: true, completion: nil)
    }

    @IBAction func selectVideo(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return
        }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .SavedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = self
        presentViewController(mediaUI, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        // Handle a movie capture
        if mediaType == kUTTypeMovie {
            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!) {
                //UISaveVideoAtPathToSavedPhotosAlbum(path!, self, nil, nil)
            }
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            playerView.player.setUrl(url)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if nextButton === sender {
            //print(liftPickerView.getSelectedLiftName())
        }
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

