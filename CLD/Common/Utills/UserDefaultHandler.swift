//
//  UserDefaultHandler.swift
//  CLD
//
//  Created by 김규철 on 2023/08/25.
//

import Foundation

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String

    @UserDefault(key: "loginStatus", defaultValue: false)
    static var loginStatus: Bool
}
