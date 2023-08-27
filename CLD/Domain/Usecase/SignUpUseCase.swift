//
//  SignUpUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/08/28.
//

import Foundation

import RxSwift

public enum SignUpError: Error {
  case failSignUp
}

public protocol SignUpUseCase {
  func trySignUp(requestDTO: SignUpRequest) -> Observable<UserToken>
}

final class DefaultSignUpUseCase: SignUpUseCase {
    
  private let signUpRepository: DefaultSignUpRepository

  // MARK: - Initializer
  public init(repository: DefaultSignUpRepository) {
      signUpRepository = repository
  }

  // MARK: - Methods
    func trySignUp(requestDTO: SignUpRequest) -> Observable<UserToken> {
        signUpRepository.trySignUp(requestDTO: requestDTO).asObservable()
    }
}
