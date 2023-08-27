//
//  DefaultSignUpRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import Foundation

import Moya
import RxSwift

final class DefaultSignUpRepository {
    
    private let signUpService: CommonMoyaProvider<AuthAPI>
    
    init() {
        self.signUpService = .init()
    }
    
    func trySignUp(requestDTO: SignUpRequest) -> Single<UserToken> {
        return signUpService.rx.request(.postSignUp(requestDTO))
            .flatMap { response in
                return Single<UserToken>.create { observer in
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let userTokenDTO = try response.map(UserTokenDTO.self)
                            let userToken = userTokenDTO.toDomain()
                            observer(.success(userToken))
                        } catch {
                            observer(.failure(error))
                        }
                    } else {
                        observer(.failure(SignUpError.failSignUp))
                    }
                    
                    return Disposables.create()
                }
            }
    }
}






