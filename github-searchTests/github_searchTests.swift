//
//  github_searchTests.swift
//  github-searchTests
//
//  Created by Lubomir Olshansky on 02/04/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import XCTest
import Moya

@testable import github_search

class github_searchTests: XCTestCase {
    
    var userDetailService: UserDetailService!
    
    override func setUp() {
        super.setUp()
         userDetailService = UserDetailService(provider: MoyaProvider<NetworkService>(stubClosure: MoyaProvider.immediatelyStub))
       
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    
    func  testGetInfo() {
        let expected = ("https://avatars2.githubusercontent.com/u/18430493?v=4", 0)
        var requestResponse: (String, Int) = ("", 5)
        
        userDetailService.loadUserDetail(name: "lubomirolshansky") {
            responce in
            requestResponse = responce
            XCTAssert(requestResponse == expected)
        }
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
