//
//  HexadAssignmentUITests.swift
//  HexadAssignmentUITests
//
//  Created by rao on 16/01/20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import XCTest

class HexadAssignmentUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Inception"]/*[[".cells.staticTexts[\"Inception\"]",".staticTexts[\"Inception\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(delay: 5)
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        wait()
        
        app.navigationBars["Inception"].buttons["Done"].tap()
        wait()
        
        let topMoviesNavigationBar = app.navigationBars["Top Movies"]
        topMoviesNavigationBar.buttons["Start Random Rating"].tap()
        wait(delay: 20)
        
        topMoviesNavigationBar.buttons["Stop Random Rating"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            
            
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func wait(delay: Double = 3.0) {
        let exp = expectation(description: "Delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: delay)
    }
}
