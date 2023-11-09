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

final class HomeViewModel: ViewModelType {
    
    private let useCase: HomeRecordUseCase
    var disposeBag = DisposeBag()
    private let recordList = BehaviorRelay<[RecordVO]>(value: [])
    private var recordListArray: [RecordVO] = []
    private var total = 0
    private var skip = 0
    
    // MARK: - Initializer
    init(
        useCase: HomeRecordUseCase
    ) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let viewWillAppearEvent: Observable<Void>
        let prefetchItems: Observable<Void>
        let didSelectReportAction: Observable<(ReportType, String)>
    }
    
    struct Output {
        let homeRecordList = PublishRelay<Void>()
        let showReportAlert = PublishRelay<Void>()
    }
    
    var collectionViewCount: Int {
        return recordList.value.count
      }
   
    func cellForItemAt(index: Int) -> RecordVO {
        return recordList.value[index]
    }
            
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getHomeRecords(limit: 4, skip: 0, output: output)
                owner.skip += 4
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .skip(1)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getHomeRecords(limit: owner.collectionViewCount, skip: owner.skip, output: output)
                owner.skip += 4
//                owner.getUserAlgorithmRecord(limit: 10, output: output)
            })
            .disposed(by: disposeBag)
        
        input.prefetchItems
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.collectionViewCount < owner.total {
                    owner.getHomeRecords(limit: owner.collectionViewCount, skip: owner.skip, output: output)
//                    owner.getUserAlgorithmRecord(limit: 4, output: output)
                    owner.skip += 4
                }
            })
            .disposed(by: disposeBag)
        
        input.didSelectReportAction
            .flatMap { [unowned self] report, id in
                self.useCase.postReport(id: id, message: report.title)
                    .catchAndReturn(output.showReportAlert.accept(()))
            }
            .bind(to: output.showReportAlert)
            .disposed(by: disposeBag)
        
        return output
    }
}

extension HomeViewModel {
    private func getHomeRecords(limit: Int, skip: Int, output: Output) {
        useCase.getHomeRecords(limit: limit, skip: skip)
            .subscribe { [weak self] response in
                switch response {
                case .success(let value):
                    self?.recordListArray.append(contentsOf: value.records)
                    self?.recordList.accept(self?.recordListArray ?? [])
                    self?.total = value.pagination.total
                    output.homeRecordList.accept(Void())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getUserAlgorithmRecord(limit: Int, output: Output) {
        useCase.getUserAlgorithmRecord(limit: limit)
            .subscribe { [weak self] response in
                switch response {
                case .success(let value):
                    self?.recordListArray.append(contentsOf: value.records)
                    self?.recordList.accept(self?.recordListArray ?? [])
                    output.homeRecordList.accept(Void())
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
