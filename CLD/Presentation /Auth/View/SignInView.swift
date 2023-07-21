//
//  SignView.swift
//  CLD
//
//  Created by 이조은 on 2023/07/19.
//

import UIKit
import SnapKit

class SignView: UIView {
    let cldLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cldLogo")
        return imageView
    }()
    let kakaoBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.setImage(UIImage(named: "kakaoLogo"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1).cgColor
        
        return button
    }()
    let appleBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.setImage(UIImage(named: "appleLogo"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1).cgColor
        
        return button
    }()
    let instaBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.setImage(UIImage(named: "instaLogo"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.683, green: 0.683, blue: 0.683, alpha: 1).cgColor
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        setButtonConfig()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubview(cldLogo)
        self.addSubview(kakaoBtn)
        self.addSubview(appleBtn)
        self.addSubview(instaBtn)
    }
    
    private func setConstraints() {
        cldLogo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(211)
            $0.height.equalTo(95)
            $0.width.equalTo(78)
            $0.leading.equalToSuperview().offset(156)
        }
        kakaoBtn.snp.makeConstraints {
            $0.top.equalTo(cldLogo.snp.bottom).offset(298)
            $0.width.equalTo(282)
            $0.height.equalTo(40)
            // $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(54)
        }
        appleBtn.snp.makeConstraints {
            $0.top.equalTo(kakaoBtn.snp.bottom).offset(14)
            $0.width.equalTo(282)
            $0.height.equalTo(40)
            // $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(54)
        }
        instaBtn.snp.makeConstraints {
            $0.top.equalTo(appleBtn.snp.bottom).offset(14)
            $0.width.equalTo(282)
            $0.height.equalTo(40)
            // $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(54)
        }
    }
    
    private func setButtonConfig() {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 7
        buttonConfiguration.baseForegroundColor = .black
        
        var titleKakao = AttributedString.init("카카오로 시작하기")
        titleKakao.font = UIFont(name: "Roboto-Bold", size: 11)
        buttonConfiguration.attributedTitle = titleKakao
        kakaoBtn.configuration = buttonConfiguration
        
        var titleApple = AttributedString.init("Apple로 시작하기")
        titleApple.font = UIFont(name: "Roboto-Bold", size: 11)
        buttonConfiguration.attributedTitle = titleApple
        appleBtn.configuration = buttonConfiguration
        
        var titleInsta = AttributedString.init("Instagram로 시작하기")
        titleInsta.font = UIFont(name: "Roboto-Bold", size: 11)
        buttonConfiguration.attributedTitle = titleInsta
        instaBtn.configuration = buttonConfiguration
    }
}
