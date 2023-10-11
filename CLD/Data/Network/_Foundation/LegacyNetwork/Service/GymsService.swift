//
//  GymsService.swift
//  CLD
//
//  Created by 이조은 on 2023/09/04.
//

import Foundation

import Moya

final class GymsService {

    private var gymsProvider = MoyaProvider<GymsAPI>()

    private enum ResponseData {
        case getGyms
    }

    public func getGyms(keyword: String, limit: Int, skip: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        gymsProvider.request(.getGyms(keyword: keyword, limit: limit, skip: skip)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getGyms)
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
            case .getGyms:
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
        case .getGyms:
            let decodedData = try? decoder.decode(GetGymsDTO.self, from: data)
            return .success(decodedData ?? "success")
        }
    }
}
