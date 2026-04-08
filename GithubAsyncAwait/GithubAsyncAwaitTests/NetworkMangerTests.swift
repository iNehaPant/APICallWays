//
//  NetworkMangerTests.swift
//  GithubAsyncAwaitTests
//
//  Created by Neha Pant on 26/08/2023.
//

import XCTest
@testable import GithubAsyncAwait

final class NetworkMangerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager(session: urlSession, baseURL: "https://google.com")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func tesGetGithubUsers() async {
        //given
        let expectation = XCTestExpectation(description: "Get Github Network Service")
        setUserMockProtocol()
        
        //when
        let mockUserData = [User(id: 35, login: "kevwil")]
        
        //then
        do {
            let data: [User] = try await self.sut.getGitHubUsers()
            XCTAssertEqual(data, mockUserData)
            expectation.fulfill()
        } catch {
            XCTFail("Error occurred: \(error)")
        }
        
        await XCTWaiter().fulfillment(of: [expectation], timeout: 20.0)
    }
    
    func setUserMockProtocol() {
        MockURLProtocol.requestHandler = { request in
            let usersData =
                """
                                  [
                
                                  {
                                  "login": "kevwil",
                                  "id": 35,
                                  "node_id": "MDQ6VXNlcjM1",
                                  "avatar_url": "https://avatars.githubusercontent.com/u/35?v=4",
                                  "gravatar_id": "",
                                  "url": "https://api.github.com/users/kevwil",
                                  "html_url": "https://github.com/kevwil",
                                  "followers_url": "https://api.github.com/users/kevwil/followers",
                                  "following_url": "https://api.github.com/users/kevwil/following{/other_user}",
                                  "gists_url": "https://api.github.com/users/kevwil/gists{/gist_id}",
                                  "starred_url": "https://api.github.com/users/kevwil/starred{/owner}{/repo}",
                                  "subscriptions_url": "https://api.github.com/users/kevwil/subscriptions",
                                  "organizations_url": "https://api.github.com/users/kevwil/orgs",
                                  "repos_url": "https://api.github.com/users/kevwil/repos",
                                  "events_url": "https://api.github.com/users/kevwil/events{/privacy}",
                                  "received_events_url": "https://api.github.com/users/kevwil/received_events",
                                  "type": "User",
                                  "site_admin": false
                                  }
                                  ]
                """
                .data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, usersData)
        }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
