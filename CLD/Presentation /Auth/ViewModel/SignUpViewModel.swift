//
//  SignUpViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/08/16.
//

import Foundation

import RxRelay
import RxSwift

class SignUpViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: SignUpUseCase
    private var eventInfoTermsAgreed = false
    
    // MARK: - Initializer
    init(
        useCase: SignUpUseCase
    ) {
        self.useCase = useCase
    }
    
    struct Input {
        let totalTerms: Observable<Bool>
        let useRequiredTerms: Observable<Bool>
        let personalInfoTerms: Observable<Bool>
        let eventInfoTerms: Observable<Bool>
        let signUpButtonTapped: Observable<Void>
    }
    
    struct Output {
        let totalTermsChecked = PublishRelay<Bool>()
        let nextButtonEnabled = PublishRelay<Bool>()
        let didSuccessSignUp = PublishRelay<Bool>()
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        Observable.combineLatest(input.useRequiredTerms, input.personalInfoTerms, input.eventInfoTerms, resultSelector: { $0 && $1 && $2 })
            .bind(to: output.totalTermsChecked)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.useRequiredTerms, input.personalInfoTerms, resultSelector: { $0 && $1 })
            .bind(to: output.nextButtonEnabled)
            .disposed(by: disposeBag)
        
        input.totalTerms
            .bind(to: output.nextButtonEnabled)
            .disposed(by: disposeBag)
        
        input.eventInfoTerms
            .withUnretained(self)
            .bind { owner, bool in
                owner.eventInfoTermsAgreed = bool
            }
            .disposed(by: disposeBag)

        input.signUpButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let requestDTO = SignUpRequest(
                    agreements: [TermsType.termsOfUseRequired.agreement(agree: true), TermsType.personalInfoCollectionRequired.agreement(agree: true),
                        TermsType.eventInfoConsent.agreement(agree: owner.eventInfoTermsAgreed)],
                    auth: Auth(accessToken: UserDefaultHandler.snsAccessToken,
                    device: DeviceData(deviceID: UUID.getDeviceUUID()),
                    loginType: UserDefaultHandler.snsLoginType))
                dump(requestDTO)
                owner.trySignUp(output: output, requestDTO: requestDTO)
            })
            .disposed(by: disposeBag)
        
        return output
    }
        
    private func trySignUp(output: Output, requestDTO: SignUpRequest) {
        useCase.trySignUp(requestDTO: requestDTO)
            .subscribe { response in
                switch response {
                case .success(let userToken):
                    UserDefaultHandler.accessToken = userToken.accessToken
                    UserDefaultHandler.refreshToken = userToken.refreshToken
                    output.didSuccessSignUp.accept(true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
