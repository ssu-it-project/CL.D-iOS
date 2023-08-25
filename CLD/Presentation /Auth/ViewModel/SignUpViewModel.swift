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
    
    struct Input {
        let totalTerms: Observable<Bool>
        let useRequiredTerms: Observable<Bool>
        let personalInfoTerms: Observable<Bool>
        let eventInfoTerms: Observable<Bool>
//        let nextButtonTapped: Observable<Void>
//        let backButtonTapped: Observable<Void>
    }
    
    struct Output {
        let totalTermsChecked: PublishRelay<Bool>
        let nextButtonEnabled: Signal<Bool>
        let eventInfoTermsAgreed: Signal<Bool>
    }
    
    func transform(input: Input) -> Output {
        let nextButtonEnabled = PublishSubject<Bool>()
        let eventInfoTermsAgreed = PublishSubject<Bool>()
        let totalTermsChecked = PublishRelay<Bool>()
        
        Observable.combineLatest(input.useRequiredTerms, input.personalInfoTerms, input.eventInfoTerms, resultSelector: { $0 && $1 && $2 })
            .bind(to: totalTermsChecked)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.useRequiredTerms, input.personalInfoTerms, resultSelector: { $0 && $1 })
            .bind(to: nextButtonEnabled)
            .disposed(by: disposeBag)
        
        input.totalTerms
            .bind(to: nextButtonEnabled)
            .disposed(by: disposeBag)
        
        input.eventInfoTerms
            .bind(to: eventInfoTermsAgreed)
            .disposed(by: disposeBag)
        
        return Output(totalTermsChecked: totalTermsChecked, nextButtonEnabled: nextButtonEnabled.asSignal(onErrorJustReturn: false), eventInfoTermsAgreed: eventInfoTermsAgreed.asSignal(onErrorJustReturn: false))
    }
}
