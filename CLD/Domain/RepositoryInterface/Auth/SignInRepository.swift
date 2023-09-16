//
//  SignInRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import RxSwift

protocol SignInRepository: AnyObject {
  func tryAppleLogin(requestDTO: SignInRequest) -> Single<UserToken>
  func tryKakaoLogin() -> Observable<UserToken>
}
