//
//  ClimbingGymVideoUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import Foundation

import RxSwift

protocol ClimbingGymVideoUseCase {
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO>
}

final class DefaultClimbingGymVideoUseCase: ClimbingGymVideoUseCase {
    
    private let disposeBag = DisposeBag()
    private let gymsRepository: GymsRepository
    
    // MARK: - Initializer
    init(gymsRepository: GymsRepository) {
        self.gymsRepository = gymsRepository
    }
        
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO> {
        gymsRepository.getDetailGymRecord(id: id, keyword: keyword, limit: limit, skip: skip)
    }
}
