//
//  Comment.swift
//  liftorum
//
//  Created by Voxy on 11/22/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import Alamofire

final class Comment : ResponseObjectSerializable, ResponseCollectionSerializable{
    let id: Int
    let createdAt: NSDate
    let text: String
    let lift_id: Int
    let user: User

    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        let createdAt = representation.valueForKeyPath("created_at") as! String
        self.createdAt = convertISOStringToNSDate(createdAt)
        self.text = representation.valueForKeyPath("text") as! String
        self.lift_id = representation.valueForKeyPath("lift_id") as! Int
        self.user = User(
            response:response,
            representation: representation.valueForKeyPath("user")!
        )!
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
    
    class func create(
        text: String,
        liftId: Int,
        userId: Int,
        completionHandler: Response<Comment, NSError> -> Void
    ){
        let parameters: [String: AnyObject] = [
            "text": text,
            "lift_id": liftId,
            "user_id": userId,
        ]
        
        let request = Alamofire.request(Router.CreateComment(parameters))
        request.validate().responseObject{
            (response: Response<Comment, NSError>) in completionHandler(response)
        }
        
    }
    
}