//
//  UserDTO.swift
//  CLD
//
//  Created by 이조은 on 2023/09/21.
//

import Foundation

// MARK: - UserDTO
struct UserDTO: Decodable {
    let id: String
    let profile: Profile
    let agreements: [MyPageAgreement]
    let count: Count
}

// MARK: - Agreement
struct MyPageAgreement: Decodable {
    let id: String
    let agreed: Bool
    let timestamp: String
}

// MARK: - Count
struct Count: Decodable {
    let record, community: Community
}

// MARK: - Community
struct Community: Decodable {
    let post: Int
    let like: Like
    let comment: Int
}

// MARK: - Like
struct Like: Decodable {
    let given, received: Int
}

// MARK: - Profile
struct Profile: Decodable {
    let name, nickname: String
    let image: String
    let birthday: String
    let gender: Int
    let physical: Physical
}

// MARK: - Physical
struct Physical: Decodable {
    let height, reach: Int
}
