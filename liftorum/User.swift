//
//  User.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire

final class User: ResponseObjectSerializable{
    let username: String
    let id: Int
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        // map the values to the instance
        self.id = representation.valueForKeyPath("id") as! Int
        self.username = representation.valueForKeyPath("username") as! String
    }
    
    class func login(
        email:String,
        password: String,
        completionHandler: Response<AnyObject, NSError> -> Void
    ) {
        let parameters = [
            "email": email,
            "password": password
        ]
        Alamofire.request(Router.Login(parameters)).validate().responseJSON{
            (response: Response) in completionHandler(response)
        }
        
    }
    
}