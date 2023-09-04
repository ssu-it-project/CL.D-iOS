//
//  ClimeGymsDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/09/04.
//

import Foundation

struct ClimeGyms: Codable {
    let climbingGyms: [ClimbingGym]
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case climbingGyms = "climbing_gyms"
        case pagination
    }
}

// MARK: - ClimbingGym
struct ClimbingGym: Codable {
    let id: String
    let location: Location
    let place: Place
    let type: String
}

// MARK: - Location
struct Location: Codable {
    let distance, x, y: Int
}

// MARK: - Place
struct Place: Codable {
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
struct Pagination: Codable {
    let limit, skip, total: Int
}
