//
//  ClimbingGymDetailViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import Foundation

import RxRelay
import RxSwift

final class ClimbingGymDetailViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: ClimbingGymDetailUseCase
    var id: String
    
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
        let tapBookmark: Observable<Bool>
    }
    
    struct Output {
        var placeVO = PublishRelay<DetailPlaceVO>()
        var gymTitle = PublishRelay<String>()
        var recordVideoURL = PublishRelay<String>()
        var recordLevel = PublishRelay<(String, String)>()
        var recordVideoIsEmpty = PublishRelay<Bool>()
        var latitude = PublishRelay<Double>()
        var longitude = PublishRelay<Double>()
        var kakaoMapPoint = PublishRelay<(Double, Double, String)>()
    }
    
    var placeID = PublishRelay<String>()
    var placeIDURL: String = ""
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDetailGym(id: owner.id, output: output)
                owner.getDetailGymRecord(output: output)
            })
            .disposed(by: disposeBag)
        
        Observable.zip(output.latitude, output.longitude, output.gymTitle)
            .bind(to: output.kakaoMapPoint)
            .disposed(by: disposeBag)
        
        placeID
            .map { placeID in
                return URLConst.kakaoMap + placeID
            }
            .withUnretained(self)
            .subscribe(onNext: { owner, placeURL in
                owner.placeIDURL = placeURL
            })
            .disposed(by: disposeBag)
                
        
        return output
    }
}

extension ClimbingGymDetailViewModel {
    private func getDetailGym(id: String, output: Output) {
        useCase.getDetailGym(id: id)
            .subscribe { [weak self] response in
                switch response {
                case .success(let value):
                    output.placeVO.accept(value.place)
                    output.gymTitle.accept(value.place.name)
                    output.latitude.accept(value.location.x)
                    output.longitude.accept(value.location.y)
                    self?.placeID.accept(value.place.placeID)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getDetailGymRecord(output: Output) {
        useCase.getDetailGymRecord(id: self.id, keyword: "", limit: 1, skip: 0)
            .subscribe { response in
                switch response {
                case .success(let value):
                    if value.pagination.total == 0 {
                        output.recordVideoIsEmpty.accept(false)
                    }
                    let record = value.records
                    output.recordVideoURL.accept(record[safe: 0]?.video ?? "")
                    output.recordLevel.accept((record[safe: 0]?.level ?? "회색", record[safe: 0]?.sector ?? "CLD"))
                case .failure(let error):
                    print(error.localizedDescription)
                    output.recordVideoIsEmpty.accept(false)
                }
            }
            .disposed(by: disposeBag)
        }
}
