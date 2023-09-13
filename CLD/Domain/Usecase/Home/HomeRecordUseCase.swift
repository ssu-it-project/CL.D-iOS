//
//  RecordUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation

import RxSwift

enum RecordError: Error {
    case getRecordError
}

protocol HomeRecordUseCase {
    func getHomeRecords(limit: Int, skip: Int) -> Single<RecordListVO>
}


final class DefaultHomeRecordUseCase: HomeRecordUseCase {
    
    private let disposeBag = DisposeBag()
    private let recordRepository: RecordRepository
    
    // MARK: - Initializer
    init(recordRepository: RecordRepository) {
        self.recordRepository = recordRepository
    }
    
    func getHomeRecords(limit: Int, skip: Int) -> Single<RecordListVO> {
        recordRepository.getRecords(limit: limit, skip: skip)
    }
}
