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
    case putUserImageAPI(image: UIImage)
    case putUserInfoAPI(birthday: String, gender: Int, name: String, nickname: String, height: Int, reach: Int)
}

extension UserAPI: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .getUserAPI, .putUserInfoAPI:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(UserDefaultHandler.accessToken)"]
        case .putUserImageAPI:
            return ["Content-Type": "multipart/form-data",
                    "Authorization": "Bearer \(UserDefaultHandler.accessToken)"]
        }
    }

    var path: String {
        switch self {
        case .getUserAPI:
            return URLConst.mypage
        case .putUserImageAPI:
            return URLConst.mypage + "/profile/image"
        case .putUserInfoAPI:
            return URLConst.mypage + "/profile"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUserAPI: return .get
        case .putUserImageAPI, .putUserInfoAPI: return .put
        }
    }

    var task: Moya.Task {
        switch self {
        case .getUserAPI:
            return .requestPlain
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
        }
    }
}
