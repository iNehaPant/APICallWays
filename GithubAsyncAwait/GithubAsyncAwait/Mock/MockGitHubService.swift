//
//  MockGitHubService.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 26/08/2023.
//

import Foundation

struct MockGithubService: GitHubService {
    var baseURL: String
    
    func getGitHubUsers<T>() async throws -> T where T : Decodable {
        let users = [User(id: 1, login: "")]
        let jsonData = try JSONSerialization.data(withJSONObject: users, options: .prettyPrinted)
        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON Data")
        return try JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: users))
    }
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
}
