//
//  User.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

final class User: ResponseObjectSerializable{
    let username: String
    let id: Int
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        // map the values to the instance
        self.id = representation.valueForKeyPath("id") as! Int
        self.username = representation.valueForKeyPath("username") as! String
    }
    
}