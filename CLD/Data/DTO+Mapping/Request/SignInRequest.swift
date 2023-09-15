//
//  SignInRequest.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import Foundation

struct SignInRequest: Encodable {
    let accessToken: String
    let device: Device
    let loginType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case device
        case loginType = "login_type"
    }
}

// MARK: - Device
struct Device: Encodable {
    let deviceID: String
    let deviceInfo: String = "IOS"

    enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
        case deviceInfo = "device_info"
    }
}
