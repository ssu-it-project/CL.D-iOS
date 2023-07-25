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
import KakaoSDKUser
import FBSDKLoginKit

final class AuthViewController: BaseViewController {
    let signView = SignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTap()
    }
    
    override func setHierarchy() {
        self.view.addSubview(signView)
    }
    
    override func setConstraints() {
        signView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buttonTap() {
        signView.kakaoButton.rx.tap
            .bind {
                self.signInKakao()
         }.disposed(by: disposeBag)
        
        signView.appleButton.rx.tap
            .bind {
                print("appleButton 클릭")
         }.disposed(by: disposeBag)
        
        signView.instaButton.rx.tap
            .bind {
                self.loginButton()
            }.disposed(by: disposeBag)
    }
    
    private func signInKakao() {
        // isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if (UserApi.isKakaoTalkLoginAvailable()) {
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    guard let authInfo = oauthToken else { return }
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    sceneDelegate?.changeRootView()
                    print("== Kakao Login \(authInfo)")
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    guard let authInfo = oauthToken else { return }
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    sceneDelegate?.changeRootView()
                    print("== Kakao Login \(authInfo)")
                }
            }
        }
    }
    
    func loginButton() {
            let loginManager = LoginManager()
            loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
                if let error = error {
                    print("Encountered Erorr: \(error)")
                } else {
                    if let result = result {
                        print("페이스북 계정으로 로그인 성공")
                        let tokenString = result.token?.tokenString
                        let userID = result.token?.userID
                        print("token: \(userID)")
                        
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sceneDelegate?.changeRootView()
                    }
                }
            }
        }
}
