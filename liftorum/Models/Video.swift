//
//  Video.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

final class Video: Mappable{
    var id: Int?
    var fileExtension: String?
    var url: String?
    
    var filename : String{
        get{
            return String(id) + "." + fileExtension!
        }
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fileExtension <- map["file_extension"]
        url <- map["url"]
    }
    
    class func create(completionHandler: Response<Video, NSError> -> Void){
        Alamofire.request(Router.CreateVideo()).validate().responseObject{
            (response: Response<Video, NSError>) in completionHandler(response)
        }
    }
    
    func uploadToS3(url: NSURL, completionHandler: Manager.MultipartFormDataEncodingResult -> Void) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let accessToken = defaults.stringForKey("accessToken")!
        let headers = [
            "Authorization": "JWT \(accessToken)",
        ]
        Alamofire.upload(
            .POST,
            SERVER_URL + "/upload-video-to-s3",
            headers: headers,
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

    



