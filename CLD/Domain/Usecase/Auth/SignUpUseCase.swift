//
//  SignUpUseCase.swift
//  CLD
//
//  Created by 김규철 on 2023/08/28.
//

import Foundation

import RxSwift

enum SignUpError: Error {
    case failSignUp
}

protocol SignUpUseCase {
    func trySignUp(requestDTO: SignUpRequest) -> Single<UserToken>
}

final class DefaultSignUpUseCase: SignUpUseCase {
    
    private let signUpRepository: SignUpRepository
    
    // MARK: - Initializer
    init(repository: SignUpRepository) {
        signUpRepository = repository
    }
    
    // MARK: - Methods
    func trySignUp(requestDTO: SignUpRequest) -> Single<UserToken> {
        signUpRepository.trySignUp(requestDTO: requestDTO)
    }
}
