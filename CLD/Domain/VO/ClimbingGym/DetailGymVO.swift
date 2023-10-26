//
//  DetailGymVO.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import Foundation

struct DetailGymVO {
    let date: DateClassVO
    let id: String
    let isBookmarked: Bool
    let location: LocationVO
    let place: DetailPlaceVO
    let type: String
}

struct DetailPlaceVO {
    let addressName, information, name: String
    let phone, placeID, placeURL, roadAddressName: String
}
