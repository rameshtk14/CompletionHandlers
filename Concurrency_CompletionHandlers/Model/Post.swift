//
//  Post.swift
//  iOSConcurrency1
//
//  Created by RAMESH on 16/07/24.
//

import Foundation

//https://jsonplaceholder.typicode.com/users/1/posts
//https://jsonplaceholder.typicode.com/posts

struct Post: Codable,Identifiable  {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
