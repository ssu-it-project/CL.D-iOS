//
//  BaseErrorDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

struct BaseErrorDTO: Decodable {
    let code: Int
    let message: String
}
