//
//  Video.swift
//  liftorum
//
//  Created by Voxy on 11/15/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import UIKit

final class Video: ResponseObjectSerializable{
    let id: Int
    let fileExtension: String
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        // map the values to the instance
        self.id = representation.valueForKeyPath("id") as! Int
        self.fileExtension = representation.valueForKeyPath("file_extension") as! String
    }
    
}