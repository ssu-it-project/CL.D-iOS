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

class ClimbingGymSearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: ClimbingGymSearchUseCase
    
    // MARK: - Initializer
    init(
        useCase: ClimbingGymSearchUseCase
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
        
        self.useCase.authorizationDeniedStatus
            .bind(to: output.authorizationAlertShouldShow)
            .disposed(by: disposeBag)
        
        self.useCase.coodinate
            .bind(to: output.currentUserLocation)
            .disposed(by: disposeBag)
        
        return output
    }
    
    func getLocationGyms(latitude: Int, longitude: Int, keyword: String, limit: Int, skip: Int, output: Output) {
        useCase.getLocationGyms(latitude: latitude, longitude: longitude, keyword: keyword, limit: limit, skip: skip)
            .subscribe { response in
                switch response {
                case .success(let value):
                    output.gyms.accept(value)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
