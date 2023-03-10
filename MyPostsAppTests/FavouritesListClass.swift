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
    
    var viewModel: FavouritesViewModel!
    
    var repository: FavouriteRepository!
    var persistentContainer: NSPersistentContainer!
    
    override func setUp() {
        super.setUp()
        viewModel = FavouritesViewModel()
        // Create an in-memory Core Data persistent container for testing
        persistentContainer = NSPersistentContainer(name: "MyPostsApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        // Load the persistent store
        persistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
    
        viewModel = FavouritesViewModel()
  
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
