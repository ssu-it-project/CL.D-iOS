//
//  DefaultHomeRecordRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/08.
//

import Foundation

import Moya
import RxSwift

final class DefaultHomeRecordRepository: HomeRecordRepository {
    
    private let recordsService: CommonMoyaProvider<RecordAPI>
    
    init() {
        self.recordsService = .init()
    }
    
    func getRecords(limit: Int, skip: Int) -> Single<RecordListVO> {
        return recordsService.rx.request(.getRecord(limit: limit, skip: skip))
            .flatMap { response in
                return Single<RecordListVO>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let RecordListDTO = try response.map(RecordListDTO.self)
                            let RecordListVO = RecordListDTO.toDomain()
                            observer(.success(RecordListVO))
                        } catch {
                            print("==== 디코딩 에러", error)
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(RecordError.getRecordError))
                    }
                    
                    return Disposables.create()
                }
            }
    }
    
    func getUserAlgorithmRecord(limit: Int) -> Single<UserAlgorithmRecordVO> {
        return recordsService.rx.request(.getUserAlgorithmRecord(limit: limit))
            .flatMap { response in
                return Single<UserAlgorithmRecordVO>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let userAlgorithmRecordDTO = try response.map(UserAlgorithmRecordDTO.self)
                            let userAlgorithmRecordVO = userAlgorithmRecordDTO.toDomain()
                            observer(.success(userAlgorithmRecordVO))
                        } catch {
                            print("==== 디코딩 에러", error)
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(RecordError.getRecordError))
                    }
                    
                    return Disposables.create()
                }
            }
    }
}
