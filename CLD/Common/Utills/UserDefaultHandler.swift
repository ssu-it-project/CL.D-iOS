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
    
    @UserDefault(key: "snsAccessToken", defaultValue: "")
    static var snsAccessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
    
    @UserDefault(key: "snsLoginType", defaultValue: "")
    static var snsLoginType: String

    @UserDefault(key: "loginStatus", defaultValue: false)
    static var loginStatus: Bool
    
    @UserDefault(key: "birthday", defaultValue: "2023-01-23T00:00:00Z")
    static var birthday: String
    
    @UserDefault(key: "gender", defaultValue: 0)
    static var gender: Int
    
    @UserDefault(key: "image", defaultValue: "")
    static var image: String
    
    @UserDefault(key: "name", defaultValue: "")
    static var name: String
    
    @UserDefault(key: "nickname", defaultValue: "")
    static var nickname: String
    
}
