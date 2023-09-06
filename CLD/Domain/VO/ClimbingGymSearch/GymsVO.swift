//
//  Gyms.swift
//  CLD
//
//  Created by 김규철 on 2023/09/07.
//

import Foundation

struct GymsVO {
    let pagination: PaginationVO
    let climbingGyms: [ClimbingGymVO]
}

struct ClimbingGymVO {
    let id, type: String
    let place: PlaceVO
    let location: LocationVO
}

struct LocationVO {
    let x, y: Int
    let distance: Double
}

struct PlaceVO {
    let name, addressName, roadAddressName: String
    let parking: Bool
}

struct PaginationVO {
    let total, skip, limit: Int
}
