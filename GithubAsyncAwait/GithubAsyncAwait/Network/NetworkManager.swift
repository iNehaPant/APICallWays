//
//  NetworkManager.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import Foundation

protocol GitHubService {
    #warning("why var")
    var baseURl: String {get}
    func getGitHubUsers() async throws -> [User]
}

#warning("Make it through dependencies and make it generic")
struct NetworkManager: GitHubService {
    var baseURl: String
    private let session: URLSession
    
    init(session: URLSession, baseURl: String) {
        self.session = session
        self.baseURl = baseURl
    }
    
    func getGitHubUsers() async throws -> [User] {
        let url = URL(string: baseURl)!
        let(data, _) = try await self.session.data(from: url)
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }
}
