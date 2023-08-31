//
//  RecordRequest.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation

// MARK: - RecordRequest
struct RecordRequest: Codable {
    let author: Author
    let climbingGymInfo: ClimbingGymInfo
    let content: String
    let date: DateClass
    let id, image, level: String
    let likeCount: Int
    let sector, video: String
    let viewCount: Int

    enum CodingKeys: String, CodingKey {
        case author
        case climbingGymInfo = "climbing_gym_info"
        case content, date, id, image, level
        case likeCount = "like_count"
        case sector, video
        case viewCount = "view_count"
    }
}

// MARK: - Author
struct Author: Codable {
    let id, nickname, profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case profileImageURL = "profile_image_url"
    }
}

// MARK: - ClimbingGymInfo
struct ClimbingGymInfo: Codable {
    let id, name: String
}

// MARK: - DateClass
struct DateClass: Codable {
    let created, modified: String
}

