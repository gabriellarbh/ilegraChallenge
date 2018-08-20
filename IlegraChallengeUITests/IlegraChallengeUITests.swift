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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

    }
    
    func testCharacterSelection() {
        
        
        let app = XCUIApplication()
        
        sleep(10)
        let tablesQuery = app.tables
        
        let elementsQuery = app.scrollViews.otherElements
        let emptyListTable = elementsQuery.tables["Empty list"]
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["3-D Man"]/*[[".cells.staticTexts[\"3-D Man\"]",".staticTexts[\"3-D Man\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(4)
        let nAStaticText = elementsQuery.staticTexts["N/A"]
        nAStaticText.swipeUp()
        
        sleep(4)
        let tablesQuery2 = elementsQuery.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Avengers: The Initiative (2007) #15"]/*[[".cells.staticTexts[\"Avengers: The Initiative (2007) #15\"]",".staticTexts[\"Avengers: The Initiative (2007) #15\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(4)
        nAStaticText.swipeUp()
        
        sleep(4)
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Avengers: The Initiative (2007) #18"]/*[[".cells.staticTexts[\"Avengers: The Initiative (2007) #18\"]",".staticTexts[\"Avengers: The Initiative (2007) #18\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        
        sleep(4)
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Marvel Premiere (1972) #35"]/*[[".cells.staticTexts[\"Marvel Premiere (1972) #35\"]",".staticTexts[\"Marvel Premiere (1972) #35\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
                
        
        sleep(4)
        
        
    }
    
    func testDetailsScreen() {
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
