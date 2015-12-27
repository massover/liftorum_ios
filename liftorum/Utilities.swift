//
//  Utilities.swift
//  liftorum
//
//  Created by Voxy on 12/9/15.
//  Copyright © 2015 liftorum. All rights reserved.
//
import UIKit
import Foundation

func convertISOStringToNSDate(ISOString: String) -> NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    return dateFormatter.dateFromString(ISOString)!
}