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
    
    var url: NSURL!
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
            url = info[UIImagePickerControllerMediaURL] as! NSURL
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path!) {
                //UISaveVideoAtPathToSavedPhotosAlbum(url.path!, self, nil, nil)
            }
            playerView.player.setUrl(url)
            Alamofire.request(Router.CreateVideo(fileExtension: "MOV"))
                .responseObject { (response: Response<Video, NSError>) in
                    switch response.result {
                    case .Success:
                        self.video = response.result.value!
                        print(self.video.fileExtension)
                        self.uploadVideoToS3()
                    case .Failure(let error):
                        print(error)
                    }
            }
        }

    }
    
    func uploadVideoToS3(){
        Alamofire.upload(
            .POST,
            "http://cd19dc2a.ngrok.io/upload-video-to-s3-2",
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: self.url, name: "file")
                multipartFormData.appendBodyPart(data: self.video.filename.dataUsingEncoding(NSUTF8StringEncoding)!, name: "filename")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        print("made it")
                        print(response.result)
                        debugPrint(response)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

