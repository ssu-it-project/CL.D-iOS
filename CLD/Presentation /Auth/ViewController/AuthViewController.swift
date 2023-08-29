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
import AuthenticationServices

final class AuthViewController: BaseViewController {
    let signView = SignView()
    private var loginManager: SNSLoginManager = CLD.SNSLoginManager()
    private let viewModel: SignInViewModel
    private let appleSignInSubject: PublishSubject<String> = .init()
    
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
        bindAction()
//        buttonTap()

    }
    
    private func bind() {
        let input = SignInViewModel.Input(kakaoButtonTapped: signView.kakaoButton.rx.tap.asObservable(), appleSignInSubject: appleSignInSubject.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.didSuccessSignIn
            .withUnretained(self)
            .bind { owner, Success in
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
    
    private func bindAction() {
        signView.appleButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.signInWithApple()
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
}
extension AuthViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
      ) {
        // Apple ID 연동 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
          let token: String = String(data: appleIDCredential.identityToken!, encoding: .utf8)!
          appleSignInSubject.onNext(token)

        default: break
        }
      }
    
    func authorizationController(
      controller: ASAuthorizationController,
      didCompleteWithError error: Error
    ) {
      // Apple ID 연동 실패
    }
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

private extension AuthViewController {
    func signInWithApple() {
        let appleIDProvider: ASAuthorizationAppleIDProvider = .init()
        let request: ASAuthorizationAppleIDRequest = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController: ASAuthorizationController = .init(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
      }
}
