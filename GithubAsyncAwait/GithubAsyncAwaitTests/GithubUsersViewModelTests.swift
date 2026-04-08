//
//  GithubUsersViewModelTests.swift
//  GithubAsyncAwaitTests
//
//  Created by Neha Pant on 17/08/2023.
//

import XCTest
@testable import GithubAsyncAwait

final class GithubUsersViewModelTests: XCTestCase {
    var sut: GithubUsersViewModel!
    
    override func setUp() {
       super.setUp()
       sut = GithubUsersViewModel(network: MockGithubService(baseURL: "https://google.com"))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        //given
        let expectation = self.expectation(description: "Fetch User ViewModel data")
        let mockArray = [User(id: 1, login: "")]
        
        //when
        sut.fetchUsers()
        
        //then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.sut.users,  mockArray)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
