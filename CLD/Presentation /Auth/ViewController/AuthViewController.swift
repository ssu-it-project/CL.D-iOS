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
    private var AuthUseCase: AuthUseCase = CLD.AuthUseCase()
    
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
                self.AuthUseCase.KakaoSignin()
         }.disposed(by: disposeBag)
        
        signView.appleButton.rx.tap
            .bind {
                print("appleButton 클릭")
         }.disposed(by: disposeBag)
        
        signView.instaButton.rx.tap
            .bind {
                self.AuthUseCase.FBSignin(AuthViewController())
            }.disposed(by: disposeBag)
    }
}
