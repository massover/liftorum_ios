//
//  Lift.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import DateTools
import Foundation

final class Lift : Mappable{
    var createdAt: NSDate?
    var id: Int?
    var name: String?
    var weight: Int?
    var reps: Int?
    var text: String?
    var user: User?
    var comments: [Comment]?
    var video: Video?
    
    var commentsButtonTitle: String{
        get{
            if comments!.count == 0 {
                return ""
            } else if comments!.count == 1{
                return String(comments!.count) + " Comment"
            } else {
                return String(comments!.count) + " Comments"
            }
        }
    }
    
    var description: String{
        get{
            return name! + ": " + String(weight!) + "lbs for " + String(reps!) + " reps"
        }
    }
    
    
    required init?(_ map: Map) {
    }
        
    // Mappable
    func mapping(map: Map) {
        createdAt <- (map["created_at"], DateFormatterTransform(dateFormatter: getDateFormatter()))
        id <- map["id"]
        name <- map["name"]
        weight <- map["weight"]
        reps <- map["reps"]
        text <- map["text"]
        user <- map["user"]
        comments <- map["comments"]
        video <- map["video"]
    }
    
    class func create(
        name: String,
        weight: Int,
        reps: Int,
        videoId: Int,
        userId: Int,
        text: String?=nil,
        completionHandler: Response<Lift, NSError> -> Void
    ){
        var parameters: [String: AnyObject] = [
            "name": name,
            "weight": weight,
            "reps": reps,
            "video_id": videoId,
            "user_id": userId,
        ]
        if let text = text {
            parameters["text"] = text
        }
        
        let request = Alamofire.request(Router.CreateLift(parameters))
        request.validate().responseObject{
            (response: Response<Lift, NSError>) in completionHandler(response)
        }
        
    }
    
    class func getLifts(page: Int, completionHandler: Response<[Lift], NSError> -> Void){
        Alamofire.request(Router.GetLifts(page: page)).validate().responseArray("objects"){
            (response: Response<[Lift], NSError>) in
            completionHandler(response)
        }
    }
    
    class func getLift(id: Int, completionHandler: Response<Lift, NSError> -> Void){
        Alamofire.request(Router.GetLift(id:id)).validate().responseObject(){
             (response: Response<Lift, NSError>) in completionHandler(response)
        }
    }
    
}


