//
//  Utilities.swift
//  liftorum
//
//  Created by Voxy on 12/9/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import Foundation

func convertISOStringToNSDate(ISOString: String) -> NSDate{
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    return dateFormatter.dateFromString(ISOString)!
}