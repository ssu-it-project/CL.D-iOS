//
//  RecordService.swift
//  CLD
//
//  Created by 이조은 on 2023/08/30.
//

import Foundation
import Moya

final class RecordService {

    private var recordProvider = MoyaProvider<RecordAPI>()

    private enum ResponseData {
        case postRecord
    }

    public func postRecord(climbing_gym_id: String, content: String, sector: String, level: String, video: URL, completion: @escaping (NetworkResult<Any>) -> Void) {
        recordProvider.request(.postRecord(climbing_gym_id: climbing_gym_id, content: content, sector: sector, level: level, video: video)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postRecord)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {

        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .postRecord:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            print(statusCode)
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            print(decodedData)
            return .requestErr(data)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch responseData {
        case .postRecord:
            let decodedData = try? decoder.decode(BlankDataResponse.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
