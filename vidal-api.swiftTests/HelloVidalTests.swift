//
//  vidal_api_swiftTests.swift
//  vidal-api.swiftTests
//
//  Created by Jean-Christophe GAY on 31/01/2015.
//  Copyright (c) 2015 Vidal. All rights reserved.
//

import Foundation
import XCTest
import VidalApi

class HelloVidalTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testExample() {
        XCTAssertEqual(hello(), "Hello Vidal")
    }
    
    func testHttp() {
        OHHTTPStubs.stubRequestsPassingTest({ (request: NSURLRequest!) -> Bool in
            return true
            }, withStubResponse:( { (request: NSURLRequest!) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(
                    data:"Hello Vidal".dataUsingEncoding(NSUTF8StringEncoding),
                    statusCode: 200,
                    headers: ["Content-Type" : "text/json"])
            }))
        
        let expect = expectationWithDescription("test using http mock")
        
        var result:String?
        let url = NSURL(string: "http://whatever.com")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            result = NSString(data: data, encoding: NSUTF8StringEncoding)
            expect.fulfill()
        }
        task.resume()
        
        waitForExpectationsWithTimeout(10, handler: { (error: NSError!) -> Void in
            XCTAssertEqual(result!, "Hello Vidal")
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}
