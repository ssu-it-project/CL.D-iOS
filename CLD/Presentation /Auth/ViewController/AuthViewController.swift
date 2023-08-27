//
//  AuthViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/19.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class AuthViewController: BaseViewController {
    let signView = SignView()
    private var loginManager: SNSLoginManager = CLD.SNSLoginManager()
    private let viewModel: SignInViewModel
    
    // MARK: - Inits
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
//        buttonTap()

    }
    
    private func bind() {
        let input = SignInViewModel.Input(kakaoButtonTapped: signView.kakaoButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.didSuccessSignIn
            .withUnretained(self)
            .bind { onwer, Success in
                print("로그인 성공 ====", UserDefaultHandler.accessToken)
                RootHandler.shard.update(.Main)
            }
            .disposed(by: disposeBag)
        
        output.isFirstUserRelay
            .bind { _ in
                print("미 가입 유저 입니다. ==== ", UserDefaultHandler.snsAccessToken)
                RootHandler.shard.update(.Terms)
            }
            .disposed(by: disposeBag)
    }
    
    override func setHierarchy() {
        self.view.addSubview(signView)
    }
    
    override func setConstraints() {
        signView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
//    private func buttonTap() {
//        signView.kakaoButton.rx.tap
//            .bind {
//                self.loginManager.KakaoSignin()
//         }.disposed(by: disposeBag)
//
//        signView.appleButton.rx.tap
//            .bind {
//                print("appleButton 클릭")
//         }.disposed(by: disposeBag)
//
//        signView.instaButton.rx.tap
//            .bind {
//                self.loginManager.FBSignin(TabBarController())
//            }.disposed(by: disposeBag)
//    }
}
