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

class VideoFormViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var takeVideoButton: UIButton!
    @IBOutlet weak var selectVideoButton: UIButton!
    @IBOutlet weak var playerView: PlayerView!
    
    @IBOutlet var progressBar: UIProgressView!
    
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
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        if mediaType == kUTTypeMovie {
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path!) {
                //UISaveVideoAtPathToSavedPhotosAlbum(url.path!, self, nil, nil)
            }
            playerView.player.setUrl(url)
            let uploadToS3CompletionHandler = { (encodingResult: Manager.MultipartFormDataEncodingResult) in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToBeWritten in
                        dispatch_async(dispatch_get_main_queue()) {
                            let progress = Float(totalBytesWritten/totalBytesExpectedToBeWritten)
                            self.progressBar.setProgress(progress, animated: true)
                        }
                    }
                    upload.responseJSON { response in
                        self.nextButton.enabled = true
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
            let createVideoCompletionHandler = { (result:Result<Video, NSError>) in
                switch result{
                case .Success:
                    let video = result.value!
                    self.progressBar.hidden = false
                    video.uploadToS3(url, completionHandler:uploadToS3CompletionHandler)
                case .Failure(let error):
                    print(error)
                }
            }
            Video.create(createVideoCompletionHandler)
        }

    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

