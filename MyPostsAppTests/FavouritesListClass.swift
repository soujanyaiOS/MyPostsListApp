//
//  FavouritesListClass.swift
//  MyPostsAppTests
//
//  Created by soujanya Balusu on 08/03/23.
//

import XCTest
import CoreData
@testable import MyPostsApp

class FavouritesListClass: XCTestCase {
 
    override func setUpWithError() throws {
    }
    
    override func setUp() {
        super.setUp()
       // testCoreDataStack = TestCoreDataStack(modelName: "MyPostsApp")
        
        
        viewModel = FavouritesViewModel()
        // Insert some test data into Core Data
        //insertTestData()
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
