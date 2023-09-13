//
//  GymsAPI.swift
//  CLD
//
//  Created by 이조은 on 2023/09/04.
//

import Foundation

import Moya

enum GymsAPI {
    case getGyms(keyword: String, limit: Int, skip: Int)
    case getLocationGyms(x: Double, y: Double, keyword: String, limit: Int, skip: Int)
    case getDetailGym(id: String)
}

extension GymsAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getGyms, .getLocationGyms:
            return URLConst.gyms
        case .getDetailGym(let id):
            return URLConst.gyms + "/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGyms, .getLocationGyms, .getDetailGym:
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
        case .getLocationGyms(let x, let y, let keyword, let limit, let skip):
            return .requestParameters(parameters: [
                "x": x,
                "y": y,
                "keyword": keyword,
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)
        case .getDetailGym:
            return .requestPlain
        }
    }
}
