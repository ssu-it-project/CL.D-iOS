//
//  SignInViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

class SignInViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: SignInUseCase

    // MARK: - Initializer
    init(
      useCase: SignInUseCase
    ) {
      self.useCase = useCase
    }
    
    struct Input {
        let kakaoButtonTapped: Observable<Void>
    }
    
    struct Output {
        let isFirstUserRelay = PublishRelay<Bool>()
        let didSuccessSignIn = PublishRelay<Bool>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        input.kakaoButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { onwer, _ in
                onwer.tryKakaoSignIn(output: output)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
    private func tryKakaoSignIn(output: Output) {
        useCase.tryKakaoSignIn()
            .subscribe(onNext: { userToken in
                UserDefaultHandler.accessToken = userToken.accessToken
                UserDefaultHandler.refreshToken = userToken.refreshToken
                output.didSuccessSignIn.accept(true)
            }, onError: { error in
                guard let error = error as? MoyaError else { return }
                if error.response?.statusCode == 404 {
                    output.isFirstUserRelay.accept(true)
                }
            })
            .disposed(by: disposeBag)
    }
}


