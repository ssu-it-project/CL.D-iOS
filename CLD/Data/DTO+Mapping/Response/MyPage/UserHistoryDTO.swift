//
//  UserHistoryDTO.swift
//  CLD
//
//  Created by 이조은 on 2023/09/24.
//

import Foundation

// MARK: - UserHistoryDTO
struct UserHistoryDTO: Decodable {
    let histories: [History]
    let pagination: Pagination
}

// MARK: - History
struct History: Decodable {
    let historyDate: String
    let record: Record
    let type: String
    let userBadge: UserBadge

    enum CodingKeys: String, CodingKey {
        case historyDate = "history_date"
        case record, type
        case userBadge = "user_badge"
    }
}

// MARK: - Record
struct Record: Decodable {
    let gymName, level, recordID, sector: String
    let videoExist: Bool

    enum CodingKeys: String, CodingKey {
        case gymName = "gym_name"
        case level
        case recordID = "record_id"
        case sector
        case videoExist = "video_exist"
    }
}

// MARK: - UserBadge
struct UserBadge: Decodable {
    let badgeID, image, title: String

    enum CodingKeys: String, CodingKey {
        case badgeID = "badge_id"
        case image, title
    }
}

