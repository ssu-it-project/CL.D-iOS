//
//  GymsRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/14.
//

import RxSwift

protocol GymsRepository: AnyObject {
    func getLocationGyms(latitude: Double, longitude: Double, keyword: String, limit: Int, skip: Int) -> Single<GymsVO>
    func getDetailGym(id: String) -> Single<DetailGymVO>
}
