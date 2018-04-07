//
//  github_searchTests.swift
//  github-searchTests
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import XCTest
@testable import github_search

class github_searchTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
       
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    func testSearchVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(sb, "Could not initiate storyboard for search vc creation")
        let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController
        XCTAssertNotNil(vc, "Could not instantiate search vc")
        _ = vc?.view
    }
    func testDetailVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(sb, "Could not initiate storyboard for detail vc creation")
        let vc = sb.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController
        XCTAssertNotNil(vc, "Could not instantiate detail vc ")
        _ = vc?.view
    }
    
}
