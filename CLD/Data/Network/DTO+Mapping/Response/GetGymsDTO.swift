//
//  GetGymsDTO.swift
//  CLD
//
//  Created by 이조은 on 2023/09/04.
//

import Foundation

// MARK: - GetGymsDTO
struct GetGymsDTO: Codable {
    let pagination: Pagination
    let climbingGyms: [ClimbingGym]

    enum CodingKeys: String, CodingKey {
        case pagination
        case climbingGyms = "climbing_gyms"
    }
}

// MARK: - ClimbingGym
struct ClimbingGym: Codable {
    let id, type: String
    let place: Place
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let x, y: Int
    let distance: Double
}

// MARK: - Place
struct Place: Codable {
    let name, addressName, roadAddressName: String
    let parking, shower: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case parking, shower
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, skip, limit: Int
}


