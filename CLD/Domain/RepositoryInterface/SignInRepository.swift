//
//  SignInRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/08/29.
//

import RxSwift

public protocol SignInRepository: AnyObject {
  func tryAppleLogin(requestDTO: SignInRequest) -> Single<UserToken>
  func tryKakaoLogin() -> Observable<UserToken>
}
