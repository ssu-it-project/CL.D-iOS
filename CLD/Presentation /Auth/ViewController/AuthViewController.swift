//
//  AuthViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/19.
//

import UIKit
import SnapKit
import RxSwift

class AuthViewController: BaseViewController {
    let signView = SignView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
    }
    
    private func setLayouts() {
        setHierarchy()
        setConstraints()
    }
    
    override func setViewProperty() {
        self.view.backgroundColor = .white
    }
    
    override func setHierarchy() {
        self.view.addSubview(signView)
    }
    
    override func setConstraints() {
        
    }
    
    func click() {
        signView.kakaoBtn.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    
    @objc func kakaoButtonTapped() {
        print("kakao 로그인")
    }
}
