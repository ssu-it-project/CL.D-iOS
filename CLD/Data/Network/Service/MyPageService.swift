//
//  MyPageService.swift
//  CLD
//
//  Created by 이조은 on 2023/09/24.
//

import Foundation

import Moya

final class MyPageService {

    private var myPageProvider = MoyaProvider<UserAPI>()

    private enum ResponseData {
        case getUser
        case getUserHistory
        case putUserImage
        case putUserInfo
    }

    public func getUser(completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.getUserAPI) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getUser)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }

    public func getUserHistory(type: String, start_date: String, end_date: String, limit: Int, skip: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.getUserHistoryAPI(type: type, start_date: start_date, end_date: end_date, limit: limit, skip: skip)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getUserHistory)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }

    public func putUserImage(image: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.putUserImageAPI(image: image)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .putUserImage)
                completion(networkResult)

            case .failure(let error):
                print(error)

            }
        }
    }

    public func putUserInfo(birthday: String, gender: Int, name: String, nickname: String, height: Int, reach: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        myPageProvider.request(.putUserInfoAPI(birthday: birthday, gender: gender, name: name, nickname: nickname, height: height, reach: reach)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .putUserInfo)
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
            case .getUser, .getUserHistory, .putUserImage, .putUserInfo:
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
        case .getUser:
            guard let decodedData = try? decoder.decode(UserDTO.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getUserHistory:
            guard let decodedData = try? decoder.decode(UserHistoryDTO.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .putUserImage:
            guard let decodedData = try? decoder.decode(BlankDataResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .putUserInfo:
            guard let decodedData = try? decoder.decode(BlankDataResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }

}
