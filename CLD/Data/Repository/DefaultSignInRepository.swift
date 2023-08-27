//
//  DefaultSignInRepository.swift
//  CLD
//
//  Created by 김규철 on 2023/08/27.
//

import Foundation

import Moya
import RxSwift
import RxKakaoSDKUser
import KakaoSDKUser

final class DefaultSignInRepository {

    private let signInService: CommonMoyaProvider<AuthAPI>
    
    init() {
        self.signInService = .init()
    }
    
    public func tryKakaoLogin() -> Observable<UserToken> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
                .withUnretained(self)
                .flatMapLatest { owner, oAuthToken in
                    owner.requestKaKaoUserInfo()
                    let dto = SignInRequest(accessToken: oAuthToken.accessToken, device: Device(deviceID: UUID.getDeviceUUID()), loginType: SNSLoginType.kakao.rawValue)
                    UserDefaultHandler.snsAccessToken = oAuthToken.accessToken
                    UserDefaultHandler.snsLoginType = SNSLoginType.kakao.rawValue
                    return owner.requestKakaoSignIn(requestDTO: dto)
                }
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount()
                .withUnretained(self)
                .flatMapLatest { owner, oAuthToken in
                    owner.requestKaKaoUserInfo()
                    let dto = SignInRequest(accessToken: oAuthToken.accessToken, device: Device(deviceID: UUID.getDeviceUUID()), loginType: SNSLoginType.kakao.rawValue)
                    UserDefaultHandler.snsAccessToken = oAuthToken.accessToken
                    UserDefaultHandler.snsLoginType = SNSLoginType.kakao.rawValue
                    return owner.requestKakaoSignIn(requestDTO: dto)
                }
        }
    }
}

extension DefaultSignInRepository {
    private func requestKakaoSignIn(requestDTO: SignInRequest) -> Single<UserToken> {
            signInService.rx.request(.postSignIn(requestDTO))
                .map(UserTokenDTO.self)
                .map { $0.toDomain() }
        }
    
    private func requestKaKaoUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            }  else {
                guard let user = user, let userInfo = user.kakaoAccount else { return }
                if userInfo.birthdayNeedsAgreement == true { UserDefaultHandler.birthday = userInfo.birthday ?? "" }
                if userInfo.genderNeedsAgreement == true {
                    if userInfo.gender == .Male {
                        UserDefaultHandler.gender = 0
                    } else {
                        UserDefaultHandler.gender = 1
                    }
                }
                if userInfo.nameNeedsAgreement == true { UserDefaultHandler.name = userInfo.name ?? "" }
                if userInfo.profileImageNeedsAgreement == true { UserDefaultHandler.image = userInfo.profile?.profileImageUrl?.absoluteString ?? ""}
                if userInfo.profileNicknameNeedsAgreement == true { UserDefaultHandler.nickname = userInfo.profile?.nickname ?? "" }
            }
        }
    }
}
