//
//  Comment.swift
//  liftorum
//
//  Created by Voxy on 11/22/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import ObjectMapper
import Alamofire

final class Comment : Mappable{
    var id: Int?
    var createdAt: NSDate?
    var text: String?
    var liftId: Int?
    var user: User?
    
    required init?(_ map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        createdAt <- (map["created_at"], DateFormatterTransform(dateFormatter: getDateFormatter()))
        text <- map["text"]
        liftId <- map["lift_id"]
        user <- map["user"]
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