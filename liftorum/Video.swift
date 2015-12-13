//
//  Video.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

final class Video: ResponseObjectSerializable{
    let id: Int
    let fileExtension: String
    var filename : String{
        get{
            return String(id) + "." + fileExtension
        }
    }
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        self.fileExtension = representation.valueForKeyPath("file_extension") as! String
    }
    
    class func create(completionHandler: Response<Video, NSError> -> Void){
        Alamofire.request(Router.CreateVideo()).responseObject{
            (response: Response<Video, NSError>) in completionHandler(response)
        }
    }
    
    func uploadToS3(url: NSURL, completionHandler: Manager.MultipartFormDataEncodingResult -> Void) {
        Alamofire.upload(
            .POST,
            "http://liftorum.com/upload-video-to-s3-2",
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: url, name: "file")
                multipartFormData.appendBodyPart(
                    data: self.filename.dataUsingEncoding(NSUTF8StringEncoding)!,
                    name: "filename"
                )
            },
            encodingCompletion: { encodingResult in completionHandler(encodingResult) }
        )
    }
    

}

    



