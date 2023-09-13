//
//  HomeViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/09/13.
//

import Foundation
import CoreLocation

import RxRelay
import RxSwift

import Moya

class HomeViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: HomeRecordUseCase
    
    // MARK: - Initializer
    init(
        useCase: HomeRecordUseCase
    ) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
        let homeRecordList = PublishRelay<RecordListVO>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.viewWillAppearEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getHomeRecords(limit: 10, skip: 10, output: output)
            })
            .disposed(by: disposeBag)
        return output
    }
}

extension HomeViewModel {
    func getHomeRecords(limit: Int, skip: Int, output: Output) {
        useCase.getHomeRecords(limit: limit, skip: skip)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.homeRecordList.accept(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
