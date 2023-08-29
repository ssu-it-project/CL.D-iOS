//
//  SignUpViewModel.swift
//  CLD
//
//  Created by 김규철 on 2023/08/16.
//

import Foundation

import RxCocoa
import RxSwift

class SignUpViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let useCase: SignUpUseCase
    
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
        let eventInfoTermsAgreed = BehaviorRelay<Bool>(value: false)
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
            .map { $0 }
            .bind(to: output.eventInfoTermsAgreed)
            .disposed(by: disposeBag)
        
        input.signUpButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { onwer, _ in
                let requestDTO = SignUpRequest(agreements: [Agreement(agree: output.eventInfoTermsAgreed.value, id: "64dcf036ce81c3226358cfc8")], auth: Auth(accessToken: UserDefaultHandler.snsAccessToken, device: DeviceData(deviceID: UUID.getDeviceUUID()), loginType: UserDefaultHandler.snsLoginType))
                dump(requestDTO)
                onwer.trySignUp(output: output, requestDTO: requestDTO)
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
