//
//  LogProcessorTest.swift
//  LogPageViewerTests
//
//  Created by Tyler Hays on 4/26/19.
//  Copyright © 2019 Tyler Hays. All rights reserved.
//

import XCTest
@testable import LogPageViewer

class LogProcessorTest: XCTestCase {

    var dumpyLogs = """
 123.4.5.9 - - [03/Sep/2013:18:34:48 -0600] "GET /team/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"
123.4.5.6 - - [03/Sep/2013:18:34:58 -0600] "GET /products/car/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"
123.4.5.8 - - [03/Sep/2013:18:35:08 -0600] "GET /products/desk/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36"
123.4.5.6 - - [03/Sep/2013:18:35:18 -0600] "GET /products/desk/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"
123.4.5.9 - - [03/Sep/2013:18:35:28 -0600] "GET /products/phone/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"
123.4.5.8 - - [03/Sep/2013:18:35:38 -0600] "GET /products/phone/ HTTP/1.1" 500 821 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36"
123.4.5.2 - - [03/Sep/2013:18:35:48 -0600] "GET /access/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36"
123.4.5.2 - - [03/Sep/2013:18:35:58 -0600] "GET /products/desk/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0"
123.4.5.4 - - [03/Sep/2013:18:36:08 -0600] "GET /products/desk/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36"
123.4.5.8 - - [03/Sep/2013:18:36:18 -0600] "GET /contact/ HTTP/1.1" 200 3327 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36"
"""
    
    var singleLog = "123.4.5.9 - - [03/Sep/2013:18:34:48 -0600] \"GET /team/ HTTP/1.1\" 200 3327 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:23.0) Gecko/20100101 Firefox/23.0\""
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetUserAndPage() {
        let test = LogProcessor.getUserAndPage(log: singleLog)
        
        XCTAssertEqual(test.user, "123.4.5.9")
        XCTAssertEqual(test.pageVisited, "/team/")
    }
    
    func testSeperatedLogFileInMultipleLogs() {
        let test = LogProcessor.seperatedLogFileInMultipleLogs(dumpyLogs)
        XCTAssertEqual(test.count, 10)
    }
    
    func testProcessLogs() {
        LogProcessor.processLogs(dumpyLogs)
    }
    
    func testGroupPageView() {
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
