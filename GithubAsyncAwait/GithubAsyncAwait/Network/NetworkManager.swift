//
//  NetworkManager.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//
// Test
import Foundation

protocol GitHubService {
    var baseURL: String {get}
    func getGitHubUsers<T: Decodable>() async throws -> T
}

struct NetworkManager: GitHubService {
    var baseURL: String
    private let session: URLSession
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getGitHubUsers<T: Decodable>() async throws -> T {
        let url = URL(string: baseURL)!
        let(data, _) = try await self.session.data(from: url)
        let users = try JSONDecoder().decode(T.self, from: data)
        return users
    }
}
