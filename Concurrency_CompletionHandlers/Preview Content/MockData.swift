//
//  MockData.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import Foundation

extension User {
    static var mockUsers:[User] {
        Bundle.main.decode(_type: [User].self, from: "users.json")
    }
    static var mockSingleUser: User {
        Self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts:[Post] {
        Bundle.main.decode(_type: [Post].self, from: "posts.json")
    }
    static var mockSingleUser: Post {
        Self.mockPosts[0]
    }
    static var mockSingleUsersPostsArray: [Post] {
        Self.mockPosts.filter{ $0.userId == 1}
    }
}
