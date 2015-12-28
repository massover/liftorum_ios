//
//  testUser.swift
//  liftorum
//
//  Created by Voxy on 12/24/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import XCTest
import Alamofire
@testable import liftorum


class testUser: XCTestCase {
    var user: User!

    override func setUp() {
        super.setUp()
        self.setUpDatabase()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateUser() {
        let path = Router.CreateUser([:]).path
        let expectation = expectationWithDescription("\(path) 201")
        
        var _response: NSHTTPURLResponse?
        let completionHandler = { (response:Response<User, NSError>) in
            _response = response.response
            if let value = response.result.value {
                self.user = value
            } else {
                print(_response?.statusCode)
            }
            expectation.fulfill()
        }
        
        User.create(
            "testing2@example.com",
            username: "test2",
            password: "password",
            completionHandler: completionHandler
        )
        
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertEqual(_response?.statusCode, 201)
        XCTAssertEqual(self.user.email, "testing2@example.com")
        
    }

}
