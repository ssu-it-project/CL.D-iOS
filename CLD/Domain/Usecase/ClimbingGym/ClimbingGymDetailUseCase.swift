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
}
