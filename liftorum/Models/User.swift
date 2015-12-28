//
//  User.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

final class User: Mappable{
    var username: String?
    var id: Int?
    var email: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        email <- map["email"]
        id <- map["id"]
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
            (response: Response) in
            print(response)
            print("amde it")
            completionHandler(response)
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