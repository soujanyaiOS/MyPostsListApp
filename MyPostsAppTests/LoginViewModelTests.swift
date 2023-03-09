//
//  LoginViewModelTests.swift
//  MyPostsAppTests
//
//  Created by soujanya Balusu on 09/03/23.
//

import XCTest

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    func testUserIDInputField() {
        viewModel.userID = ""
        XCTAssertFalse(viewModel.isLoginEnabled)
        
        viewModel.userID = "1"
        XCTAssertTrue(viewModel.isLoginEnabled)
        
    }
    
    func testLoginAPIWithValidUserID() {
        let userID = "1"
        let expectation = XCTestExpectation(description: "login")
        
        // Call the login API with the valid userID
        viewModel.loginAPI(userID: userID){ data in
            // Checking for API call was successful if valid posts and there is no error
            
            switch data {
            case .success(let post):
                XCTAssertEqual(post.count, 10)
                XCTAssertTrue(true)
                
            case .failure(let error):
                XCTAssertNil(error)
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        
        
        
        // Wait for the expectation to be fulfilled with a timeout of 10 seconds
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
