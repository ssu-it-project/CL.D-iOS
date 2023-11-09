//
//  AuthAPI.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

import Moya

enum AuthAPI {
    case postSignUp(_ requestDTO: SignUpRequest)
    case postSignIn(_ requestDTO: SignInRequest)
    case postRefreshToken(device: String, refresh_token: String)
}

extension AuthAPI: BaseTargetType {
    
    var headers: [String : String]? {
        switch self {
        case .postSignUp, .postSignIn, .postRefreshToken:
            return ["Content-Type": "application/json"]
        }
    }
    
    var path: String {
        let baseUserRoutePath: String = "/user"
        let baseAuthRoutePath: String = "/auth"
        
        switch self {
        case .postSignUp: return baseUserRoutePath
        case .postSignIn: return baseAuthRoutePath + "/token"
        case .postRefreshToken: return baseAuthRoutePath + "/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp, .postSignIn, .postRefreshToken: return .post
        }
    }
    
    var sampleData: Data {
        return .init()
    }
        
    var task: Task {
        switch self {
        case .postSignUp(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        case .postSignIn(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        case .postRefreshToken(let device, let refresh_token):
            return .requestParameters(parameters: [
                "device_id": device,
                "refresh_token": refresh_token
            ], encoding: JSONEncoding.default)
        }
    }
}
