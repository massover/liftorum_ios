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
    
    var video: Video!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as? UINavigationController
        let liftFormViewController = navigationController?.topViewController as? LiftFormViewController
        liftFormViewController!.video = video
    }

    
    @IBAction func takeVideo(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .Camera
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func selectVideo(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .SavedPhotosAlbum
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        if mediaType == kUTTypeMovie {
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            playerView.player.setUrl(url)
            let uploadToS3CompletionHandler = { (encodingResult: Manager.MultipartFormDataEncodingResult) in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                        dispatch_async(dispatch_get_main_queue()) {
                            let progress = Float(totalBytesWritten/totalBytesExpectedToWrite) - 0.1
                            self.progressBar.setProgress(progress, animated: true)
                        }
                    }
                    upload.responseJSON { response in
                        self.progressBar.setProgress(1.0, animated: true)
                        self.nextButton.enabled = true
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
            let createVideoCompletionHandler = { (response:Response<Video, NSError>) in
                switch response.result{
                case .Success:
                    self.video = response.result.value!
                    self.progressBar.hidden = false
                    self.video.uploadToS3(url, completionHandler:uploadToS3CompletionHandler)
                case .Failure(let error):
                    print(error)
                }
            }
            Video.create(createVideoCompletionHandler)
//            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path!) {
//                UISaveVideoAtPathToSavedPhotosAlbum(url.path!, self, nil, nil)
//            }
        }

    }
    
}

