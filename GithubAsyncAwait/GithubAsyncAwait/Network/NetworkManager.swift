//
//  NetworkManager.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import Foundation

protocol GitHubService {
    var baseURl: String {get}
    func getGitHubUsers<T: Decodable>() async throws -> T
}

struct NetworkManager: GitHubService {
    var baseURl: String
    private let session: URLSession
    
    init(session: URLSession, baseURl: String) {
        self.session = session
        self.baseURl = baseURl
    }
    
    func getGitHubUsers<T: Decodable>() async throws -> T {
        let url = URL(string: baseURl)!
        let(data, _) = try await self.session.data(from: url)
        let users = try JSONDecoder().decode(T.self, from: data)
        return users
    }
}
