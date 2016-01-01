//
//  testVideo.swift
//  liftorum
//
//  Created by Voxy on 12/28/15.
//  Copyright © 2015 liftorum. All rights reserved.
//

import XCTest
import Alamofire
@testable import liftorum

extension XCTestCase{
    func createVideo() -> Video{
        let path = Router.CreateUser([:]).path
        let expectation = expectationWithDescription("\(path) 201")
        var video: Video!
        
        var _response: NSHTTPURLResponse?
        let completionHandler = { (response:Response<Video, NSError>) in
            _response = response.response
            if let value = response.result.value {
                video = value
            }
            expectation.fulfill()
        }
        
        Video.create(completionHandler)
        
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssertEqual(_response?.statusCode, 201)
        XCTAssertEqual(video.fileExtension, "MOV")
        return video
    }
}

class testVideo: XCTestCase {

    override func setUp() {
        super.setUp()
        self.setUpDatabase()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        self.createVideo()
    }


}
