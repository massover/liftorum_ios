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

final class Lift : ResponseObjectSerializable, ResponseCollectionSerializable{
    let createdAt: NSDate
    let id: Int
    let user: User
    let comments: [Comment]
    let video: Video
    
    var commentsButtonTitle : String{
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
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
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
        completionHandler: Response<Lift, NSError> -> Void
    ){
        let parameters = [
            "name": name,
            "weight": weight,
            "reps": reps,
            "video_id": videoId,
            "user_id": userId,
        ]
        let request = Alamofire.request(Router.CreateLift(parameters as! [String : AnyObject]))
        request.validate().responseObject{
            (response: Response<Lift, NSError>) in completionHandler(response)
        }
        
    }
    
    class func getLifts(page: Int, completionHandler: Response<[Lift], NSError> -> Void){
        Alamofire.request(Router.GetLifts(page: page)).validate().responseCollection(){
            (response: Response<[Lift], NSError>) in completionHandler(response)
        }
    }
    
    
    
}


