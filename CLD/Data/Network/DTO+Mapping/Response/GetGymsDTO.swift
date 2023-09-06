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

extension GetGymsDTO {
    func toDomain() -> GymsVO {
        let paginationVO = PaginationVO(total: self.pagination.total, skip: self.pagination.skip, limit: self.pagination.limit)
        let climbingGymsVO = self.climbingGyms.map { $0.toDomain() }

        return GymsVO(pagination: paginationVO, climbingGyms: climbingGymsVO)
    }
}

extension ClimbingGym {
    func toDomain() -> ClimbingGymVO {
        return ClimbingGymVO(
            id: self.id,
            type: self.type,
            place: self.place.toDomain(),
            location: self.location.toDomain()
        )
    }
}

extension Place {
    func toDomain() -> PlaceVO {
        return PlaceVO(
            name: self.name,
            addressName: self.addressName,
            roadAddressName: self.roadAddressName,
            parking: self.parking
        )
    }
}

extension Location {
    func toDomain() -> LocationVO {
        return LocationVO(
            x: self.x,
            y: self.y,
            distance: self.distance
        )
    }
}








