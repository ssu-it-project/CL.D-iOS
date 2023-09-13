//
//  GetGymsDTO.swift
//  CLD
//
//  Created by 이조은 on 2023/09/04.
//

import Foundation

// MARK: - GetGymsDTO
struct GetGymsDTO: Decodable {
    let pagination: Pagination
    let climbingGyms: [ClimbingGym]
    
    enum CodingKeys: String, CodingKey {
        case climbingGyms = "climbing_gyms"
        case pagination
    }
}

// MARK: - ClimbingGym
struct ClimbingGym: Decodable {
    let id: String
    let type: String
    let place: Place
    let location: Location
}

// MARK: - Location
struct Location: Decodable {
    let x: Double
    let y: Double
    let distance: Double
}

// MARK: - Place
struct Place: Decodable {
    let name, addressName, roadAddressName: String
    let imageURL: String
    let parking, shower: Bool
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case name, parking
        case roadAddressName = "road_address_name"
        case shower
        case imageURL = "image_url"
    }
}

enum TypeEnum: String, Decodable {
    case bouldering = "bouldering"
}

// MARK: - Pagination
struct Pagination: Decodable {
    let total, skip, limit: Int
}

extension GetGymsDTO {
    func toDomain() -> GymsVO {
        let paginationVO = PaginationVO(total: pagination.total, skip: pagination.skip, limit: pagination.limit)
        let climbingGymsVO = climbingGyms.map { climbingGymDTO in
            let placeVO = climbingGymDTO.place.toDomain()
            let locationVO = climbingGymDTO.location.toDomain()
            return ClimbingGymVO(id: climbingGymDTO.id, type: climbingGymDTO.type, place: placeVO, location: locationVO)
        }
        return GymsVO(pagination: paginationVO, climbingGyms: climbingGymsVO)
    }
}

extension Place {
    func toDomain() -> PlaceVO {
        return PlaceVO(name: name, addressName: addressName, roadAddressName: roadAddressName, imageURL: imageURL, parking: parking, shower: shower)
    }
}

extension Location {
    func toDomain() -> LocationVO {
        return LocationVO(x: x, y: y, distance: distance)
    }
}
