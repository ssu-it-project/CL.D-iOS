//
//  RecordVO.swift
//  CLD
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

struct RecordListVO {
    let pagination: PaginationVO
    let records: [RecordVO]
}

// MARK: - Record
struct RecordVO {
    let author: AuthorVO
    let climbingGymInfo: ClimbingGymInfoVO
    let content: String
    let date: DateClassVO
    let id, image, level: String
    let likeCount: Int
    let sector, video: String
    let viewCount: Int
}

// MARK: - Author
struct AuthorVO {
    let id, nickname, profileImage: String
}

// MARK: - ClimbingGymInfo
struct ClimbingGymInfoVO {
    let id, name: String
}

// MARK: - DateClass
struct DateClassVO {
    let created, modified: String
}

