//
//  UserTokenDTO.swift
//  CLD
//
//  Created by 김규철 on 2023/08/26.
//

import Foundation

struct UserTokenDTO: Decodable {
    let jwt: String
    let refresh_token: String
}

extension UserTokenDTO {
    func toDomain() -> UserToken {
        return UserToken(accessToken: jwt, refreshToken: refresh_token)
    }
}
