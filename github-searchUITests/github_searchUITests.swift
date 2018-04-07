//
//  github_searchUITests.swift
//  github-searchUITests
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import XCTest

class github_searchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let searchUsersOrRepositoriesSearchField = app.searchFields["Search users or repositories..."]
        searchUsersOrRepositoriesSearchField.tap()
        searchUsersOrRepositoriesSearchField.typeText("lubomirolshansky")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["LubomirOlshansky"]/*[[".cells.staticTexts[\"LubomirOlshansky\"]",".staticTexts[\"LubomirOlshansky\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertFalse(searchUsersOrRepositoriesSearchField.exists, "Search bar no longer exists")
        let backButton = app.navigationBars["github_search.UserDetailView"].buttons["Back"]
        XCTAssert(backButton.exists, "The new navigation bar does not exist")
      
    }
    
}
