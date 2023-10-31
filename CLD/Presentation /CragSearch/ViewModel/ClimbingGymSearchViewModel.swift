//
//  ClimbingGymSearchViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/09/06.
//

import Foundation
import CoreLocation

import RxRelay
import RxSwift

final class ClimbingGymSearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: ClimbingGymUseCase
    
    // MARK: - Initializer
    init(
        useCase: ClimbingGymUseCase
    ) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
        let viewWillAppearEvent: Observable<Void>
    }
    
    struct Output {
        let currentUserLocation = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let authorizationAlertShouldShow = BehaviorRelay<Bool>(value: false)
        let gyms = PublishRelay<GymsVO?>()
        let climbingGymData = PublishRelay<[ClimbingGymVO]>()
        let bookmarkGym = PublishRelay<[BookmarkGymVO]>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.useCase.checkDeviceLocationAuthorization()
                owner.useCase.observeUserLocation()
                owner.useCase.checkAuthorization()
            })
            .disposed(by: disposeBag)
        
        input.viewWillAppearEvent
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getBookmarkGym(keyword: "", limit: 20, skip: 0, output: output)
            })
            .disposed(by: disposeBag)
        
        self.useCase.authorizationDeniedStatus
            .bind(to: output.authorizationAlertShouldShow)
            .disposed(by: disposeBag)
        
        self.useCase.coodinate
            .withUnretained(self)
            .subscribe(onNext: { owner, coodinate in
                output.currentUserLocation.accept(coodinate)
                owner.getLocationGyms(longitude: coodinate.latitude, latitude: coodinate.longitude, keyword: "", limit: 50, skip: 50, output: output)
            })
            .disposed(by: disposeBag)
        return output
    }
}

extension ClimbingGymSearchViewModel {
    private func getLocationGyms(longitude: Double, latitude: Double, keyword: String, limit: Int, skip: Int, output: Output) {
        useCase.getLocationGyms(longitude: longitude, latitude: latitude, keyword: keyword, limit: limit, skip: skip)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.gyms.accept(value)
                    output.climbingGymData.accept(value.climbingGyms)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getBookmarkGym(keyword: String, limit: Int, skip: Int, output: Output) {
        useCase.getBookmarkGym(keyword: keyword, limit: limit, skip: skip)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.bookmarkGym.accept(value.climbingGyms)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
