//
//  testComment.swift
//  liftorum
//
//  Created by Voxy on 12/30/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import Alamofire
import XCTest
@testable import liftorum

extension XCTestCase{
    func createComment(text: String, liftId: Int, userId: Int) -> Comment{
        let path = Router.CreateComment([:]).path
        let expectation = expectationWithDescription("\(path) 201")
        var comment: Comment!
        
        var _response: NSHTTPURLResponse?
        let completionHandler = { (response:Response<Comment, NSError>) in
            _response = response.response
            if let value = response.result.value {
                comment = value
            }
            expectation.fulfill()
        }
        
        Comment.create(
            text,
            liftId: liftId,
            userId: userId,
            completionHandler: completionHandler
        )
        
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertEqual(_response?.statusCode, 201)
        XCTAssertEqual(comment.text, text)
        return comment
        
    }
    
}

class testComment: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        self.setUpDatabase()
        var user: User
        var video: Video
        var lift: Lift
        
        user = self.createUser()
        video = self.createVideo()
        lift = self.createLift(user.id!, videoId: video.id!)
        self.createComment(
            "Some text for a comment",
            liftId: lift.id!,
            userId: user.id!
        )
        
    }
}
