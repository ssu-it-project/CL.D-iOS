//
//  UserAlgorithmRecordDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/11/01.
//

import Foundation

struct UserAlgorithmRecordDTO: Decodable {
    let records: [RecordDTO]
}

extension UserAlgorithmRecordDTO {
    func toDomain() -> UserAlgorithmRecordVO {
        return UserAlgorithmRecordVO(records: records.map { $0.toDomain() })
    }
}
