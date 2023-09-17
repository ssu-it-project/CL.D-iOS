//
//  DetailGymDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import Foundation

struct DetailGymDTO: Decodable {
    let date: DateClassDTO
    let id: String
    let location: Location
    let place: DetailPlaceDTO
    let type: String
}

struct DetailPlaceDTO: Decodable {
    let addressName, imageURL, information, name: String
    let parking: Bool
    let phone, placeID, placeURL, roadAddressName: String
    let shower: Bool

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case imageURL = "image_url"
        case information, name, parking, phone
        case placeID = "place_id"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case shower
    }
}

extension DetailGymDTO {
    func toDomain() -> DetailGymVO {
        return DetailGymVO(date: date.toDomain(), id: id, location: location.toDomain(), place: place.toDomain(), type: type)
    }
}

extension DetailPlaceDTO {
    func toDomain() -> DetailPlaceVO {
        return DetailPlaceVO(addressName: addressName, information: information, name: name, phone: phone, placeID: placeID, placeURL: placeURL, roadAddressName: roadAddressName)
    }
}
