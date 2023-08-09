//
//  GithubUsersViewModel.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import Foundation

class GithubUsersViewModel: ObservableObject {
    let network: GitHubService
    @Published var users = [User]()
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    init(network: GitHubService) {
        self.network = network
    }
    
    func fetchUsers() {
        Task {
            do {
                let users: [User] = try await self.network.getGitHubUsers()
                DispatchQueue.main.async {
                    self.users = users
                    self.showError = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
