//
//  RecordAPI.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation

import Moya

enum RecordAPI {
    case postRecord(climbing_gym_id: String, content: String, sector: String, level: String, video: URL )
}

extension RecordAPI: BaseTargetType {

    var headers: [String : String]? {
        switch self {
        case .postRecord:
            return ["Content-Type": "application/json"]
        }
    }

    var path: String {

        switch self {
        case .postRecord:
            return URLConst.record
        }
    }

    var method: Moya.Method {
        switch self {
        case .postRecord:
            return .post
        }
    }

    var sampleData: Data {
        return .init()
    }

    var task: Task {
        switch self {
        case .postRecord(let climbing_gym_id, let content, let sector, let level, let video):
            return .requestParameters(parameters: [
                "climbing_gym_id": climbing_gym_id,
                "content": content,
                "sector": sector,
                "level": level,
                "video": video
            ], encoding: JSONEncoding.default)
        }
    }
}
