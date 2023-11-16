//
//  ClimbingGymVideoViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import Foundation

import RxRelay
import RxSwift

final class ClimbingGymVideoViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: ClimbingGymVideoUseCase
    private var id: String
    private var title: String
    
    // MARK: - Initializer
    init(
        id: String,
        title: String,
        useCase: ClimbingGymVideoUseCase
    ) {
        self.id = id
        self.title = title
        self.useCase = useCase
    }
    
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let searchText: Observable<String>
    }
    
    struct Output {
        let recordListVO = PublishRelay<[RecordVO]>()
        let showError = PublishRelay<Error>()
        let navigationTitle = PublishRelay<String>()
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .flatMap { owner, query in
                owner.useCase.getDetailGymRecord(id: owner.id, keyword: "", limit: 20, skip: 0)
            }
            .subscribe(with: self) { owner, gym in
                output.recordListVO.accept(gym.records)
            } onError: { owner, error in
                output.showError.accept(error)
            }
            .disposed(by: disposeBag)
        
        input.searchText
            .withUnretained(self)
            .flatMap { owner, query in
                owner.useCase.getDetailGymRecord(id: owner.id, keyword: query, limit: 20, skip: 0)
            }
            .subscribe(with: self) { owner, gym in
                output.recordListVO.accept(gym.records)
            } onError: { owner, error in
                output.showError.accept(error)
            }
            .disposed(by: disposeBag)
        
        Observable.just(title)
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: output.navigationTitle)
            .disposed(by: disposeBag)
        
        return output
    }
}
