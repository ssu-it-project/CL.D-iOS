//
//  RecordAPI.swift
//  CLD
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

import Moya

enum RecordAPI {
    case getRecord(limit: Int, skip: Int)
}

extension RecordAPI: BaseTargetType {
    var path: String {
        let baseRecordRoutePath: String = "/clime"
        
        switch self {
        case .getRecord: return baseRecordRoutePath + "/records"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecord: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecord(limit: let limit, skip: let skip):
            return .requestParameters(parameters: [
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)
        }
    }
}
