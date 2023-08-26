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
}

extension AuthAPI: BaseTargetType {
    
    var headers: [String : String]? {
        switch self {
        case .postSignUp:
            return ["Content-Type": "application/json"]
        }
    }
    
    var path: String {
        let baseRoutePath: String = "/auth"
        
        switch self {
        case .postSignUp: return baseRoutePath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp: return .post
        }
    }
    
    var sampleData: Data {
        return .init()
    }
        
    var task: Task {
        switch self {
        case .postSignUp(let requestDTO):
            return .requestJSONEncodable(requestDTO)
        }
    }
}
