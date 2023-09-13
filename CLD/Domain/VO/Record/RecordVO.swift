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

struct AuthorVO {
    let id, nickname, profileImage: String
}

struct ClimbingGymInfoVO {
    let id, name: String
}

struct DateClassVO {
    let created, modified: String
}

