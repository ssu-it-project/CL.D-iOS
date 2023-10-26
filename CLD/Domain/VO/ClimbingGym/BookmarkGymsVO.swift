//
//  BookmarkGymsVO.swift
//  CLD
//
//  Created by 김규철 on 2023/10/26.
//

import Foundation

struct BookmarkGymsVO {
    let pagination: PaginationVO
    let climbingGyms: [BookmarkGymVO]
}

struct BookmarkGymVO {
    let id, type: String
    let place: PlaceVO
}
