//
//  BookmarkGymsDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/10/26.
//

import Foundation

struct BookmarkGymsDTO: Decodable {
    let pagination: Pagination
    let climbingGyms: [BookmarkGymDTO]
}

struct BookmarkGymDTO: Decodable {
    let id, type: String
    let place: Place
}

extension BookmarkGymsDTO {
    func toDomain() -> BookmarkGymsVO {
        return BookmarkGymsVO(pagination: PaginationVO(total: pagination.total, skip: pagination.skip, limit: pagination.limit), climbingGyms: climbingGyms.map { $0.toDomain() })
    }
}

extension BookmarkGymDTO {
    func toDomain() -> BookmarkGymVO {
        return BookmarkGymVO(id: id, type: type, place: place.toDomain())
    }
}
