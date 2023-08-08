//
//  GithubAsyncAwaitApp.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import SwiftUI

@main
struct GithubAsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            GithubView(vm: GithubUsersViewModel(network: NetworkManager(session: URLSession.shared,
                                                                        baseURl: "https://api.github.com/users")))
        }
    }
}
