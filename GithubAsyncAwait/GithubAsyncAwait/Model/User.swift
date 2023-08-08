//
//  User.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import Foundation

struct User: Decodable,Identifiable {
    let id: Int
    let login: String
}
