//
//  ClimbingGymSearchUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/09/06.
//

import Foundation
import CoreLocation

import RxSwift

enum ClimbingGymError: Error {
    case GymSearchError
    case detailGymError
}

protocol ClimbingGymUseCase {
    var authorizationDeniedStatus: PublishSubject<Bool> { get }
    var coodinate:  BehaviorSubject<CLLocationCoordinate2D> { get }
    
    func observeUserLocation()
    func checkAuthorization()
    func checkDeviceLocationAuthorization()
    func getLocationGyms(longitude: Double, latitude: Double, keyword: String, limit: Int, skip: Int) -> Single<GymsVO>
    func getBookmarkGym(keyword: String, limit: Int, skip: Int) -> Single<BookmarkGymsVO>
}


final class DefaultClimbingGymUseCase: ClimbingGymUseCase {
        
    private let disposeBag = DisposeBag()
    private let locationService: LocationService
    private let gymsRepository: GymsRepository
    
    var authorizationDeniedStatus = PublishSubject<Bool>()
    var coodinate = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    // MARK: - Initializer
    init(locationService: LocationService, gymsRepository: GymsRepository) {
        self.locationService = locationService
        self.gymsRepository = gymsRepository
    }
    
    // MARK: - CoreLocationUseCase
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

    // MARK: - NetworkUseCase
    func getLocationGyms(longitude: Double, latitude: Double, keyword: String, limit: Int, skip: Int) -> Single<GymsVO> {
        gymsRepository.getLocationGyms(latitude: latitude, longitude:  longitude, keyword: keyword, limit: limit, skip: skip)
      }
    
    func getBookmarkGym(keyword: String, limit: Int, skip: Int) -> Single<BookmarkGymsVO> {
        gymsRepository.getBookmarkGym(keyword: keyword, limit: limit, skip: skip)
    }
}
