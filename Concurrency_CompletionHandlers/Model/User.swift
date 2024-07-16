//
//  User.swift
//  iOSConcurrency1
//
//  Created by RAMESH on 16/07/24.
//

import Foundation



struct User: Codable,Identifiable  {
    let id: Int
    let name: String
    let email: String
    let username: String
}
