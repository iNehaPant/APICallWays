//
//  User.swift
//  GithubAsyncAwait
//
//  Created by Neha Pant on 08/08/2023.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    var id: Int
    var login: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
    }
    
    init(id: Int, login: String) {
        self.id = id
        self.login = login
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decode(String.self, forKey: .login)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(login, forKey: .login)
    }
}
