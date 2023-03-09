//
//  PostListviewclass.swift
//  MyPostsAppTests
//
//  Created by soujanya Balusu on 08/03/23.
//

import XCTest

class PostListviewclass: XCTestCase {
    
    var viewModel: PostViewModel!
    var mockApiService: MockPostApiService!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockPostApiService()
        viewModel = PostViewModel(apiService: mockApiService)
    }
    
    func testFetchPosts() {
        // Given
        let expectation = self.expectation(description: "Fetch Posts")
        var result: Result<[Post], Error>?
 
        mockApiService.getPost(userId: 1){ res in
            result = res
            expectation.fulfill()
        }
        
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            guard let posts = try? result?.get() else {
                XCTFail("Expected success, but got failure.")
                return
            }
            XCTAssertEqual(posts.count, 2)
            XCTAssertEqual(posts.first?.title, "Mock Post")
            XCTAssertEqual(posts.last?.title, "qui est esse")
            XCTAssertEqual(posts.last?.body, "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
        }
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
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
}
