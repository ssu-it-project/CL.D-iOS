//
//  ClimeGymsDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/09/04.
//

import Foundation

struct ClimeGymDummy {
    let climbingGymData: [ClimbingGymsDummy]
    let pagination: PaginationData

    enum CodingKeys: String, CodingKey {
        case climbingGymData = "climbing_gyms"
        case pagination
    }
}

// MARK: - ClimbingGym
struct ClimbingGymsDummy {
    let id: String
    let location: LocationData
    let place: PlaceData
    let type: String
}

// MARK: - Location
struct LocationData {
    let distance, x, y: Int
}

// MARK: - Place
struct PlaceData {
    let addressName, name: String
    let parking: Bool
    let roadAddressName: String
    let shower: Bool

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name, parking
        case roadAddressName = "road_address_name"
        case shower
    }
}

// MARK: - Pagination
struct PaginationData {
    let limit, skip, total: Int
}
