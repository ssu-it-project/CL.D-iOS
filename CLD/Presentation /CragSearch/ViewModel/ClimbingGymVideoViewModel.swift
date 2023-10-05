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
    var title: String
    
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
    }
    
    struct Output {
        var recordListVO = PublishRelay<[RecordVO]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDetailGymRecord(output: output)
                
            })
            .disposed(by: disposeBag)
        
        return output
    }
}

extension ClimbingGymVideoViewModel {
    private func getDetailGymRecord(output: Output) {
        useCase.getDetailGymRecord(id: self.id, keyword: "", limit: 10, skip: 0)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.recordListVO.accept(value.records)
                case .failure(let error):
                    print(error.localizedDescription)
                    output.recordListVO.accept([])
                }
            }
            .disposed(by: disposeBag)
    }
}
