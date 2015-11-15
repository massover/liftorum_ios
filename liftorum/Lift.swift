//
//  Lift.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
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

}

final class Lift : ResponseObjectSerializable{
    let createdAt: NSDate
    let id: Int
    let user: User
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.createdAt = NSDate()
        self.id = representation.valueForKeyPath("id") as! Int
        self.user = User(response:response, representation: representation.valueForKeyPath("user")!)!
    }
        
    
    func createdAtString() -> String{
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(self.createdAt)
    }
    
}



