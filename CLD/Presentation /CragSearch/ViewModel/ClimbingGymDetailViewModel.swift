//
//  ClimbingGymDetailViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import Foundation

import RxRelay
import RxSwift

class ClimbingGymDetailViewModel {
    var disposeBag = DisposeBag()
    
    private let useCase: ClimbingGymDetailUseCase
    private var id: String
    
    // MARK: - Initializer
    init(
        id: String,
        useCase: ClimbingGymDetailUseCase
    ) {
        self.id = id
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
        var placeVO = PublishRelay<DetailPlaceVO>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDetailGym(id: owner.id, output: output)
            })
            .disposed(by: disposeBag)
        
        
        return output
    }
}

extension ClimbingGymDetailViewModel {
    private func getDetailGym(id: String, output: Output) {
        useCase.getDetailGym(id: id)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.placeVO.accept(value.place)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
