//
//  SignInUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import Foundation

import RxSwift

public protocol SignInUseCase {
  func tryKakaoSignIn() -> Observable<UserToken>
}

final class DefaultSignInUseCase: SignInUseCase {

  private let signInRepository: DefaultSignInRepository

  // MARK: - Initializer
  public init(repository: DefaultSignInRepository) {
    signInRepository = repository
  }

  // MARK: - Methods
  public func tryKakaoSignIn() -> Observable<UserToken> {
      signInRepository.tryKakaoLogin()
  }
}
