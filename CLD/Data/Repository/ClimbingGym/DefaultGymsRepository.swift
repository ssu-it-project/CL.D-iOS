//
//  DefaultGymsRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/07.
//

import Foundation

import Moya
import RxSwift

final class DefaultGymsRepository: GymsRepository {
    
    private let gymsService: CommonMoyaProvider<GymsAPI>
    
    init() {
        self.gymsService = .init()
    }
    
    func getLocationGyms(latitude: Double, longitude: Double, keyword: String, limit: Int, skip: Int) -> Single<GymsVO> {
        return gymsService.rx.request(.getLocationGyms(x: latitude, y: longitude, keyword: keyword, limit: limit, skip: skip))
            .flatMap { response in
                return Single<GymsVO>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let getGymsDTO = try response.map(GetGymsDTO.self)
                            let gymsVO = getGymsDTO.toDomain()
                            observer(.success(gymsVO))
                        } catch {
                            print("====", error)
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(ClimbingGymError.GymSearchError))
                    }
                    
                    return Disposables.create()
                }
            }
    }
    
    func getDetailGym(id: String) -> Single<DetailGymVO> {
        return gymsService.rx.request(.getDetailGym(id: id))
            .flatMap { response in
                return Single<DetailGymVO>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let detailGymDTO = try response.map(DetailGymDTO.self)
                            let detailGymVO = detailGymDTO.toDomain()
                            observer(.success(detailGymVO))
                        } catch {
                            print("====", error)
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(ClimbingGymError.detailGymError))
                    }
                    return Disposables.create()
                }
            }
    }
    
    func getDetailGymRecord(id: String, keyword: String, limit: Int, skip: Int) -> Single<RecordListVO> {
        return gymsService.rx.request(.getDetailGymRecord(id: id, keyword: keyword, limit: limit, skip: skip))
            .flatMap { response in
                return Single<RecordListVO>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let gymRecordListDTO = try response.map(RecordListDTO.self)
                            let gymRecordListVO = gymRecordListDTO.toDomain()
                            observer(.success(gymRecordListVO))
                        } catch {
                            print("====", error)
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(ClimbingGymError.detailGymError))
                    }
                    return Disposables.create()
                }
            }
        
        func getBookmarkGym(keyword: String, limit: Int, skip: Int) -> Single<BookmarkGymsVO> {
            return gymsService.rx.request(.getBookmarkGym(keyword: keyword, limit: limit, skip: skip))
                .flatMap { response in
                    return Single<BookmarkGymsVO>.create { observer in
                        if (200..<300).contains(response.statusCode) {
                            do {
                                let BookmarkGymsDTO = try response.map(BookmarkGymsDTO.self)
                                let BookmarkGymsVO = BookmarkGymsDTO.toDomain()
                                observer(.success(BookmarkGymsVO))
                            } catch {
                                print("====", error)
                                observer(.failure(error))
                            }
                        } else {
                            observer(.failure(ClimbingGymError.detailGymError))
                        }
                        return Disposables.create()
                    }
                }
        }
    }
}
