//
//  GymsAPI.swift
//  CLD
//
//  Created by 이조은 on 2023/09/04.
//

import Foundation

import Moya

enum GymsAPI {
    case getGyms(keyword: String, limit: Int, skip: Int )
}

extension GymsAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getGyms:
            return URLConst.gyms
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGyms:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getGyms(let keyword, let limit, let skip):
            return .requestParameters(parameters: [
                "keyword": keyword,
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)
        }
    }
}
