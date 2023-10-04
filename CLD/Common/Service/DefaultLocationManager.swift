//
//  DefaultLocationManager.swift
//  CLD
//
//  Created by 김규철 on 2023/09/06.
//

import Foundation
import CoreLocation

import RxSwift
import RxRelay

protocol LocationService {
    var authorizationStatus: BehaviorRelay<CLAuthorizationStatus> { get set }
    var coodinate: BehaviorRelay<CLLocationCoordinate2D> { get set }
    func start()
    func stop()
    func requestAuthorization()
    func checkLocationAuthorization()
}

// CLLocationManagerDelegate 사용 위해 NSObject 상속 필요
final class DefaultLocationManager: NSObject, LocationService {
    var locationManager: CLLocationManager?
    var coodinate = BehaviorRelay<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    var authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stop() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func requestAuthorization() {
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func checkLocationAuthorization() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.authorizationStatus.accept(.denied)
                return
            }
            
            DispatchQueue.main.async {
                switch self.locationManager?.authorizationStatus {
                case .notDetermined:
                    self.authorizationStatus.accept(.notDetermined)
                    self.requestAuthorization()
                case .restricted:
                    self.authorizationStatus.accept(.restricted)
                case .denied:
                    self.authorizationStatus.accept(.denied)
                case .authorizedWhenInUse, .authorizedAlways:
                    self.authorizationStatus.accept(.authorizedWhenInUse)
                    self.start()
                @unknown default:
                    break
                }
            }
        }
        
    }
}

extension DefaultLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            self.coodinate.accept(coordinate)
            print("==", coodinate.value)
            print("==\(#function)", coordinate)
            
        }
        stop()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("==\(#function)", manager.authorizationStatus.rawValue)
        authorizationStatus.accept(manager.authorizationStatus)
        checkLocationAuthorization()
    }
}
