//
//  Interceptor.swift
//  CLD
//
//  Created by 김규철 on 2023/11/09.
//

import Foundation

import Alamofire
import Moya
import RxMoya
import RxSwift

final class Interceptor: RequestInterceptor {
    
    private let tokenService = MoyaProvider<AuthAPI>(session: Moya.Session(), plugins: [NetworkPlugin()])
    private let disposeBag = DisposeBag()
    private let limit = 2
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + UserDefaultHandler.accessToken, forHTTPHeaderField: "Authorization")
        
        print("adapt 적용 \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard request.retryCount < limit, response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        tryRefreshToken()
            .subscribe { result in
                switch result {
                case .success(let success):
                    if success {
                        completion(.retry)
                    }
                case .failure(let error):
                    dump("tryRefreshToken Error : \(error.localizedDescription)")
                    completion(.doNotRetry)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func tryRefreshToken() -> Single<Bool> {
        return tokenService.rx.request(.postRefreshToken(device: DeviceUUID.getDeviceUUID(), refresh_token: UserDefaultHandler.refreshToken))
            .map(UserTokenDTO.self)
            .flatMap { tokenDTO in
                UserDefaultHandler.accessToken = tokenDTO.jwt
                UserDefaultHandler.refreshToken = tokenDTO.refresh_token
                return .create { observer in
                    observer(.success(true))
                    return Disposables.create()
                }
            }
    }
}
