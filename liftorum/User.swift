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
    let email: String
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        self.username = representation.valueForKeyPath("username") as! String
        self.email = representation.valueForKeyPath("email") as! String
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
    
    class func create(
        email: String,
        username: String,
        password: String,
        completionHandler: Response<User, NSError> -> Void
    ){
        let parameters: [String: AnyObject] = [
            "email": email,
            "username": username,
            "password": password,
        ]
            
        let request = Alamofire.request(Router.CreateUser(parameters))
        request.validate().responseObject{
            (response: Response<User, NSError>) in completionHandler(response)
        }
            
    }
    
}