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


extension XCTestCase{
    func createUser() -> User{
        let path = Router.CreateUser([:]).path
        let expectation = expectationWithDescription("\(path) 201")
        var user: User!
        
        var _response: NSHTTPURLResponse?
        let completionHandler = { (response:Response<User, NSError>) in
            _response = response.response
            if let value = response.result.value {
                user = value
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
        XCTAssertEqual(user.email, "testing2@example.com")
        return user
    }
}

class testUser: XCTestCase {

    override func setUp() {
        super.setUp()
        self.setUpDatabase()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateUser() {
        self.createUser()
    }
}
