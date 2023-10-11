//
//  UserAPI.swift
//  CLD
//
//  Created by 이조은 on 2023/09/24.
//

import Foundation

import Moya

enum UserAPI {
    case getUserAPI
    case getUserHistoryAPI(type: String, start_date: String, end_date: String, limit: Int, skip: Int)
    case putUserImageAPI(image: UIImage)
    case putUserInfoAPI(birthday: String, gender: Int, name: String, nickname: String, height: Int, reach: Int)
    case postLogoutUserAPI(device: String, refresh_token: String)
    case deleteUserAPI
}

extension UserAPI: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .getUserAPI, .getUserHistoryAPI, .putUserInfoAPI, .postLogoutUserAPI, .deleteUserAPI:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(UserDefaultHandler.accessToken)"]
        case .putUserImageAPI:
            return ["Content-Type": "multipart/form-data",
                    "Authorization": "Bearer \(UserDefaultHandler.accessToken)"]
        }
    }

    var path: String {
        switch self {
        case .getUserAPI, .deleteUserAPI:
            return URLConst.mypage
        case .getUserHistoryAPI:
            return URLConst.mypage + "/history"
        case .putUserImageAPI:
            return URLConst.mypage + "/profile/image"
        case .putUserInfoAPI:
            return URLConst.mypage + "/profile"
        case .postLogoutUserAPI:
            return URLConst.auth + "/logout"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUserAPI, .getUserHistoryAPI: return .get
        case .putUserImageAPI, .putUserInfoAPI: return .put
        case .postLogoutUserAPI: return .post
        case .deleteUserAPI: return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getUserAPI, .deleteUserAPI:
            return .requestPlain

        case .getUserHistoryAPI(let type, let start_date, let end_date, let limit, let skip):
            return .requestParameters(parameters: [
                "type": type,
                "start_date": start_date,
                "end_date": end_date,
                "limit": limit,
                "skip": skip
            ], encoding: URLEncoding.default)

        case .putUserImageAPI(let image):
            let imageData = MultipartFormData(provider: .data(image.jpegData(compressionQuality: 1.0)!), name: "image", fileName: "jpeg", mimeType: "image/jpeg")
            return .uploadMultipart([imageData])

        case .putUserInfoAPI(let birthday, let gender, let name, let nickname, let height, let reach):
            return .requestParameters(parameters: [
                "birthday": birthday,
                "gender": gender,
                "name": name,
                "nickname": nickname,
                "physical": [
                    "height": height,
                    "reach": reach
                ]
            ], encoding: JSONEncoding.default)
            
        case .postLogoutUserAPI(let device, let refresh_token):
            return .requestParameters(parameters: [
                "device": device,
                "refresh_token": refresh_token
            ], encoding: JSONEncoding.default)
        }
    }
}
