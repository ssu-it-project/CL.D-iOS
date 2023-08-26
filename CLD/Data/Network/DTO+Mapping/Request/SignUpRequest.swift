//
//  SignUpRequest.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

struct SignUpRequest: Encodable {
    let agreements: [Agreement]
    let auth: Auth
    let profile: ProfileData
}

// MARK: - Agreement
struct Agreement: Encodable {
    let agreed: Bool
    let id: String
    let timestamp: Date
}

// MARK: - Auth
struct Auth: Encodable {
    let accessToken: String
    let device: DeviceData
    let loginType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case device
        case loginType = "login_type"
    }
}

// MARK: - Device
struct DeviceData: Encodable {
    let deviceID: String
    let deviceInfo: String = "IOS"

    enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
        case deviceInfo = "device_info"
    }
}

// MARK: - Profile
struct ProfileData: Encodable {
    let birthday: Date
    let gender: Int
    let image, name, nickname: String
    let physical: Physical
}

// MARK: - Physical
struct Physical: Encodable {
    let height, reach: Int
}
