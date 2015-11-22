//
//  Comment.swift
//  liftorum
//
//  Created by Voxy on 11/22/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

final class Comment : ResponseObjectSerializable, ResponseCollectionSerializable{
    let id: Int
    let createdAt: NSDate
    let text: String
    let lift_id: Int
    let user_id: Int

    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        let createdAt = representation.valueForKeyPath("created_at") as! String
        self.createdAt = convertISOStringToNSDate(createdAt)
        self.text = representation.valueForKeyPath("text") as! String
        self.lift_id = representation.valueForKeyPath("lift_id") as! Int
        self.user_id = representation.valueForKeyPath("user_id") as! Int
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Comment] {
        var comments: [Comment] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for commentRepresentation in representation {
                if let comment = Comment(response: response, representation: commentRepresentation) {
                    comments.append(comment)
                }
            }
        }
        return comments
    }
    
}