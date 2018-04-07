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
    
    let provider = MoyaProvider<NetworkService>(stubClosure: MoyaProvider.immediatelyStub)
    var resData: Data? = nil
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    
    func  testGetInfo() {
        
        provider.request(.getUserInfo(userName: "lubomirolhansky")) { (result) in
            
            switch result {
            case .success(let response):
                
                self.resData = response.data
                
                
            case .failure(let error):
                print(error)
            }
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data recived from the server")
        } else {
            XCTAssert(false, "The call to get some other error")
        }
    }
    func  testGetUsers() {
        
        provider.request(.getUserRep(name: "lubomirolhansky")) { (result) in
            
            switch result {
            case .success(let response):
                
                self.resData = response.data
                
                
            case .failure(let error):
                print(error)
            }
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data recived from the server")
        } else {
            XCTAssert(false, "The call to get some other error")
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
