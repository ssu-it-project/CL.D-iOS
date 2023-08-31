//
//  NetworkService.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    private init() { }

    let record = RecordService()
}
