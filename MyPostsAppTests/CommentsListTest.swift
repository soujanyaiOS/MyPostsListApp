//
//  CommentsListTest.swift
//  MyPostsAppTests
//
//  Created by soujanya Balusu on 10/03/23.
//

import XCTest

class CommentsListTest: XCTestCase {
    var viewModel: CommnetsViewmodel!
    var mockApiService: MockCommentApiService!
    var sut: CommnetsViewmodel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        
        mockApiService = MockCommentApiService()
        viewModel = CommnetsViewmodel(commentApiService: mockApiService)
    }
    
    func testNumberOfComments() {
        let expectedCount = viewModel.comments.count
        XCTAssertEqual(0, expectedCount)
    }
    
    func testCommentAtIndex() {
        
        // Given
        let expectation = self.expectation(description: "Fetch Comments")
        var result: Result<[Comment], Error>?
        
        mockApiService.getComments(postID: 1){ res in
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
            XCTAssertEqual(posts.count, 5)
            XCTAssertEqual(posts.first?.name, "id labore ex et quam laborum")
            XCTAssertEqual(posts.last?.email, "Hayden@althea.biz")
            XCTAssertEqual(posts.first?.body, "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
            XCTAssertEqual(posts.last?.postID, 1)
            XCTAssertEqual(posts.last?.id, 5)
        }
    }
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
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
