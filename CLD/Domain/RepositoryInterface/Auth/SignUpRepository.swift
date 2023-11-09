//
//  SignUpRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/11/09.
//

import RxSwift

protocol SignUpRepository: AnyObject {
    func trySignUp(requestDTO: SignUpRequest) -> Single<UserToken>
}
