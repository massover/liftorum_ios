//
//  Utilities.swift
//  liftorum
//
//  Created by Voxy on 12/27/15.
//  Copyright © 2015 liftorum. All rights reserved.
//
import XCTest
import Alamofire
@testable import liftorum

extension XCTestCase{
    func setUpDatabase() {
        let expectation = expectationWithDescription("\(SERVER_URL) 200")
        var _response: NSHTTPURLResponse?
        let request = Alamofire.request(.GET, SERVER_URL + "/testing/setup")
        request.validate().responseJSON { response in
            _response = response.response
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertEqual(_response?.statusCode, 200)
    }
    
}