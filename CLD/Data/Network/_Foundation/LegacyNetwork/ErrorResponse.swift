//
//  ErrorResponse.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation

struct ErrorResponse: Codable {
    let timeStamp: String?
    let status: Int?
    let error: String?
    let message: String?
}
