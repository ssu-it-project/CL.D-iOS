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
    case getUserAlgorithmRecord(limit: Int)
    case postReport(id: String, message: String)
}

extension RecordAPI: BaseTargetType {
    var path: String {
        let baseRecordRoutePath: String = "/clime"
        
        switch self {
        case .getRecord: return baseRecordRoutePath + "/records"
        case .getUserAlgorithmRecord: return baseRecordRoutePath + "/record/next"
        case .postReport(let id, _): return baseRecordRoutePath + "/record/\(id)/report"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecord, .getUserAlgorithmRecord: return .get
        case .postReport: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecord(limit: let limit, skip: let skip):
            return .requestParameters(parameters: [
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)
        case .getUserAlgorithmRecord(limit: let limit):
            return .requestParameters(parameters: [
                "limit": limit
            ], encoding: URLEncoding.default)
        case .postReport(_, message: let message):
            return .requestParameters(parameters: [
                "message": message
            ], encoding: URLEncoding.httpBody)
        }
    }
}
