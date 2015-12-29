//
//  testLift.swift
//  liftorum
//
//  Created by Voxy on 12/28/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import Alamofire
import XCTest
@testable import liftorum

extension XCTestCase{
    func createLift(userId: Int, videoId: Int) -> Lift{
        let path = Router.CreateLift([:]).path
        let expectation = expectationWithDescription("\(path) 201")
        var lift: Lift!
        
        var _response: NSHTTPURLResponse?
        let completionHandler = { (response:Response<Lift, NSError>) in
            _response = response.response
            if let value = response.result.value {
                lift = value
            }
            expectation.fulfill()
        }
        
        Lift.create(
            "squat",
            weight: 315,
            reps: 5,
            videoId: videoId,
            userId: userId,
            text: "text for a comment",
            completionHandler: completionHandler
        )
        
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertEqual(_response?.statusCode, 201)
        XCTAssertEqual(lift.name, "squat")
        return lift
    }
}

class testLift: XCTestCase {

    override func setUp() {
        super.setUp()
        self.setUpDatabase()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreateLift() {
        var user: User!
        var video: Video!
        user = self.createUser()
        video = self.createVideo()
        self.createLift(user.id!, videoId: video.id!)
    }

}
