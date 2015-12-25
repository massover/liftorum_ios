//
//  Lift.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire
import DateTools
import Foundation

final class Lift : ResponseObjectSerializable, ResponseCollectionSerializable{
    let createdAt: NSDate
    let id: Int
    let name: String
    let weight: Int
    let reps: Int
    let text: String?
    let user: User
    let comments: [Comment]
    let video: Video
    
    var commentsButtonTitle: String{
        get{
            if comments.count == 0 {
                return ""
            } else if comments.count == 1{
                return String(comments.count) + " Comment"
            } else {
                return String(comments.count) + " Comments"
            }
        }
    }
    
    var description: String{
        get{
            return name + ": " + String(weight) + "lbs for " + String(reps) + " reps"
        }
    }
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        self.name = representation.valueForKeyPath("name") as! String
        self.weight = representation.valueForKeyPath("weight") as! Int
        self.reps = representation.valueForKeyPath("reps") as! Int
        if representation.valueForKeyPath("text") is NSNull {
            self.text = nil
        } else {
            self.text = representation.valueForKeyPath("text") as? String
        }
        let createdAt = representation.valueForKeyPath("created_at") as! String
        
        self.createdAt = convertISOStringToNSDate(createdAt)
        self.user = User(
            response:response,
            representation: representation.valueForKeyPath("user")!
        )!
        self.comments = Comment.collection(
            response: response,
            representation: representation.valueForKeyPath("comments")!
        )
        self.video = Video(
            response:response,
            representation: representation.valueForKeyPath("video")!
        )!
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Lift] {
        var lifts: [Lift] = []
        if let representation = representation as? [[String: AnyObject]] {
            for liftRepresentation in representation {
                if let lift = Lift(response: response, representation: liftRepresentation) {
                    lifts.append(lift)
                }
            }
        }
        
        return lifts
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
        Alamofire.request(Router.GetLifts(page: page)).validate().responseCollection(){
            (response: Response<[Lift], NSError>) in completionHandler(response)
        }
    }
    
    class func getLift(id: Int, completionHandler: Response<Lift, NSError> -> Void){
        Alamofire.request(Router.GetLift(id:id)).validate().responseObject(){
             (response: Response<Lift, NSError>) in completionHandler(response)
        }
    }
    
}


