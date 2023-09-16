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

final class DefaultSignInRepository: SignInRepository {
    
    private let signInService: CommonMoyaProvider<AuthAPI>
    
    init() {
        self.signInService = .init()
    }
    
    func tryAppleLogin(requestDTO: SignInRequest) -> Single<UserToken> {
        return signInService.rx.request(.postSignIn(requestDTO))
            .map(UserTokenDTO.self)
            .flatMap { tokenDTO in
                return .create { observer in
                    observer(.success(tokenDTO.toDomain()))
                    return Disposables.create()
                }
            }
    }
    
    func tryKakaoLogin() -> Observable<UserToken> {
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
                .withUnretained(self)
                .flatMapLatest { owner, oAuthToken in
                    owner.saveSNSAccessToken(oAuthToken.accessToken)
                    owner.saveSNSLoginType(SNSLoginType.kakao.rawValue)
                    let dto = SignInRequest(accessToken: oAuthToken.accessToken, device: Device(deviceID: DeviceUUID.getDeviceUUID()), loginType: SNSLoginType.kakao.rawValue)
                    return owner.requestKakaoSignIn(requestDTO: dto)
                }
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount()
                .withUnretained(self)
                .flatMapLatest { owner, oAuthToken in
                    owner.saveSNSAccessToken(oAuthToken.accessToken)
                    owner.saveSNSLoginType(SNSLoginType.kakao.rawValue)
                    let dto = SignInRequest(accessToken: oAuthToken.accessToken, device: Device(deviceID: DeviceUUID.getDeviceUUID()), loginType: SNSLoginType.kakao.rawValue)
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
    
    private func saveSNSAccessToken(_ accessToken: String) {
        UserDefaultHandler.snsAccessToken = accessToken
    }
    
    private func saveSNSLoginType(_ loginType: String) {
        UserDefaultHandler.snsLoginType = loginType
    }
}
