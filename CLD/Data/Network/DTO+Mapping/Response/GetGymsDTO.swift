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
    let id: String
    let type: TypeEnum
    let place: Place
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

enum TypeEnum: String, Codable {
    case bouldering = "bouldering"
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, skip, limit: Int
}
