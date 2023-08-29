//
//  NetworkError.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

enum NetworkError: Error {
    case requestErr(BaseErrorDTO)
    case decodedErr
    case pathErr
    case ServerError
}
