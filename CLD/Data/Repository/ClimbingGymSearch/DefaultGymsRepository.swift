//
//  DefaultGymsRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/07.
//

import Foundation

import Moya
import RxSwift

final class DefaultGymsRepository {
    
    private let gymsService: CommonMoyaProvider<GymsAPI>
    
    init() {
        self.gymsService = .init()
    }
    
    func getLocationGyms(latitude: Int, longitude: Int, keyword: String, limit: Int, skip: Int) -> Single<GymsVO?> {
        return gymsService.rx.request(.getLocationGyms(x: latitude, y: longitude, keyword: keyword, limit: limit, skip: skip))
            .flatMap { response in
                return Single<GymsVO?>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let getGymsDTO = try response.map(GetGymsDTO.self)
                            let gymsVO = getGymsDTO.toDomain()
                            observer(.success(gymsVO))
                        } catch {
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(ClimbingGymSearchError.failGymSearchError))
                    }
                    
                    return Disposables.create()
                }
            }
    }
}
