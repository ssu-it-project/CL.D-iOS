//
//  RecordRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/13.
//

import RxSwift

protocol HomeRecordRepository: AnyObject {
    func getRecords(limit: Int, skip: Int) -> Single<RecordListVO>
    func getUserAlgorithmRecord(limit: Int) -> Single<UserAlgorithmRecordVO>
}
