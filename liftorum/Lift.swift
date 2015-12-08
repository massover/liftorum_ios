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

func convertISOStringToNSDate(ISOString: String) -> NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    return dateFormatter.dateFromString(ISOString)!
}

final class Lift : ResponseObjectSerializable, ResponseCollectionSerializable{
    let createdAt: NSDate
    let id: Int
    let user: User
    let comments: [Comment]
    let video: Video
    
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
    
    
    
}


