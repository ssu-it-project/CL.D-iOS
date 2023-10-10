//
//  SignView.swift
//  CLD
//
//  Created by 이조은 on 2023/07/19.
//

import UIKit

import SnapKit

final class SignView: UIView {
    private let cldLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.cldLogo
        return imageView
    }()
    let kakaoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .KakaoYellow
        button.setImage(ImageLiteral.kakaoLogo, for: .normal)
        button.layer.cornerRadius = 6
        
        return button
    }()
    let appleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(ImageLiteral.appleLogo, for: .normal)
        button.layer.cornerRadius = 6

        return button
    }()
    let instaButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = .clear
        button.setImage(ImageLiteral.instaLogo, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        addSubviews(cldLogo, kakaoButton, appleButton, instaButton)
    }
    
    func setConstraints() {
        cldLogo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(211)
            $0.height.equalTo(95)
            $0.width.equalTo(78)
            $0.centerX.equalToSuperview()
        }
        kakaoButton.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(42)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(200)
        }
        appleButton.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(42)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(148)
        }
//        instaButton.snp.makeConstraints {
//            $0.top.equalTo(appleButton.snp.bottom).offset(14)
//            $0.width.equalTo(280)
//            $0.height.equalTo(42)
//            $0.centerX.equalToSuperview()
//        }
    }
}
