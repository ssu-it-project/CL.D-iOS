//
//  ClimbingGymSearchUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/09/06.
//

import Foundation
import CoreLocation

import RxSwift


final class ClimbingGymSearchUseCase {
    
    var authorizationDeniedStatus = PublishSubject<Bool>()
    var coodinate = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    private let disposeBag = DisposeBag()
    private let locationService: LocationService
    
    // MARK: - Initializer
     init(locationService: LocationService) {
         self.locationService = locationService
    }
    
    func observeUserLocation() {
        self.locationService.coodinate
            .subscribe { [weak self] coodinate in
                self?.coodinate.onNext(coodinate)
            }
            .disposed(by: disposeBag)
    }
    
    func checkAuthorization() {
        self.locationService.authorizationStatus
            .subscribe { [weak self] authorizationStatus in
                if authorizationStatus == .denied {
                    self?.authorizationDeniedStatus.onNext(true)
                } else {
                    self?.authorizationDeniedStatus.onNext(false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func checkDeviceLocationAuthorization() {
        self.locationService.checkLocationAuthorization()
    }
}
