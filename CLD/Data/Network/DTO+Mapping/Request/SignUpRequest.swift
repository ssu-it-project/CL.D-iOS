//
//  SignUpRequest.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

public struct SignUpRequest: Encodable {
    let agreements: [Agreement]
    let auth: Auth
}

// MARK: - Agreement
struct Agreement: Encodable {
    let agree: Bool
    let id: String
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
