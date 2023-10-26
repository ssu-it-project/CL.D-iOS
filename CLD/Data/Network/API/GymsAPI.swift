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
    case getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int)
    case getBookmarkGym(keyword: String, limit: Int, skip: Int)
    case postBookmark(id: String)
}

extension GymsAPI: BaseTargetType {
    var path: String {
        let baseDetailGymRoutePath: String = "/clime/gym"
        
        switch self {
        case .getGyms, .getLocationGyms:
            return URLConst.gyms
        case .getDetailGym(let id):
            return baseDetailGymRoutePath + "/\(id)"
        case .getDetailGymRecord(let id, _, _, _):
            return baseDetailGymRoutePath + "/\(id)" + "/records"
        case .getBookmarkGym:
            return baseDetailGymRoutePath + "/bookmark"
        case .postBookmark(id: let id):
            return baseDetailGymRoutePath + "/\(id)" + "/bookmark"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGyms, .getLocationGyms, .getDetailGym, .getDetailGymRecord, .getBookmarkGym:
            return .get
        case .postBookmark:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getGyms(let keyword, let limit, let skip), .getBookmarkGym(let keyword, let limit, let skip):
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
        case .getDetailGymRecord(id: _, keyword: let keyword, limit: let limit, skip: let skip):
            return .requestParameters(parameters: [
                "keyword": keyword,
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)
        case .postBookmark(id: _):
            return .requestPlain
        }
    }
}
