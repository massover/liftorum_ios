//
//  liftorumTests.swift
//  liftorumTests
//
//  Created by Voxy on 11/1/15.
//  Copyright © 2015 liftorum. All rights reserved.
//
import XCTest
@testable import liftorum

class liftorumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConvertISOStringToNSDate() {
        let date = convertISOStringToNSDate("2015-12-25T05:00:00.000000")
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = 25
        components.month = 12
        components.year = 2015
        XCTAssertEqual(date, calendar.dateFromComponents(components))
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
}
