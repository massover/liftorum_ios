//
//  Lift.swift
//  liftorum
//
//  Created by Voxy on 11/14/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

class Lift {
    var username: String
    var createdAt: NSDate
    
    init(username: String, createdAt: NSDate){
        self.username = username
        self.createdAt = createdAt
    }
    
    func createdAtString() -> String{
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(self.createdAt)
    }
    
}
