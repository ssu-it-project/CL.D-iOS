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
        let prefetchItems: PublishSubject<Void>
    }
    
    struct Output {
        let homeRecordList = PublishRelay<RecordListVO>()
    }
    
    let recordList = BehaviorSubject<[RecordVO]>(value: [])
    var collectionViewCount: Int {
          guard let count = try? recordList.value().count else { return 0 }
          return count
      }
    var recordListArray: [RecordVO] = []
    
    var total = 0
    var skip = 4
    
    func cellInfo(index: Int) -> RecordVO? {
        return try? recordList.value()[index]
    }
    
    func cellArrayInfo(index: Int) -> RecordVO {
        return recordListArray[index]
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.viewWillAppearEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getHomeRecords(limit: 4, skip: 0, output: output)
            })
            .disposed(by: disposeBag)
        
        input.prefetchItems
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.collectionViewCount < owner.total {
                    owner.getHomeRecords(limit: 4, skip: owner.skip, output: output)
                    owner.skip += 4
                }
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension HomeViewModel {
    func getHomeRecords(limit: Int, skip: Int, output: Output) {
        useCase.getHomeRecords(limit: limit, skip: skip)
            .subscribe { [weak self] response in
                switch response {
                case .success(let value):
                    self?.recordListArray.append(contentsOf: value.records)
                    self?.total = value.pagination.total
                    output.homeRecordList.accept(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
