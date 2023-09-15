//
//  ClimbingGymDetailUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import Foundation

import RxSwift

protocol ClimbingGymDetailUseCase {
    func getDetailGym(id: String) -> Single<DetailGymVO>
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO>
}

final class DefaultClimbingGymDetailUseCase: ClimbingGymDetailUseCase {
    
    private let disposeBag = DisposeBag()
    private let gymsRepository: GymsRepository
    
    // MARK: - Initializer
    init(gymsRepository: GymsRepository) {
        self.gymsRepository = gymsRepository
    }
    
    func getDetailGym(id: String) -> Single<DetailGymVO> {
        gymsRepository.getDetailGym(id: id)
    }
    
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO> {
        gymsRepository.getDetailGymRecord(id: id, keyword: keyword, limit: limit, skip: skip)
    }
}
