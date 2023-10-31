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
    let sector: String
    let video: VideoVO
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

struct VideoVO: Decodable {
    let original, resolution, video480: String
}

extension RecordVO: Equatable, Hashable {
    static func == (lhs: RecordVO, rhs: RecordVO) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

