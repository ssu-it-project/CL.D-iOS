//
//  LoginManager.swift
//  CLD
//
//  Created by 이조은 on 2023/07/25.
//

import KakaoSDKUser
import FBSDKLoginKit

class SNSLoginManager {
    func KakaoSignin() {
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
    
    func FBSignin(_ AuthViewController: AuthViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: AuthViewController) { result, error in
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
