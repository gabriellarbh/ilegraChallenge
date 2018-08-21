//
//  IlegraChallengeUITests.swift
//  IlegraChallengeUITests
//
//  Created by Gabriella Barbieri on 17/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import XCTest

class IlegraChallengeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()

    }
// swiftlint:disable line_length
    func testCharacterSelection() {
        let app = XCUIApplication()
        sleep(10)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["3-D Man"]/*[[".cells.staticTexts[\"3-D Man\"]",".staticTexts[\"3-D Man\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(4)
        let scrollViewsQuery = app.scrollViews
        let textView = scrollViewsQuery.otherElements.containing(.staticText, identifier: "3-D Man").children(matching: .textView).element
        textView.tap()
        sleep(4)
        textView.swipeDown()
        sleep(4)
        textView.swipeUp()
        sleep(4)
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["Appears In"].tap()
        sleep(4)
        let tablesQuery = elementsQuery.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Avengers: The Initiative (2007) #18"]/*[[".cells.staticTexts[\"Avengers: The Initiative (2007) #18\"]",".staticTexts[\"Avengers: The Initiative (2007) #18\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(4)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Marvel Premiere (1972) #35"]/*[[".cells.staticTexts[\"Marvel Premiere (1972) #35\"]",".staticTexts[\"Marvel Premiere (1972) #35\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(4)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Avengers: The Initiative (2007) #18 (ZOMBIE VARIANT)"]/*[[".cells.staticTexts[\"Avengers: The Initiative (2007) #18 (ZOMBIE VARIANT)\"]",".staticTexts[\"Avengers: The Initiative (2007) #18 (ZOMBIE VARIANT)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        sleep(4)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Avengers: The Initiative (2007) #15"]/*[[".cells.staticTexts[\"Avengers: The Initiative (2007) #15\"]",".staticTexts[\"Avengers: The Initiative (2007) #15\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        sleep(4)
    }

    override func tearDown() {
        super.tearDown()
    }
    
}
