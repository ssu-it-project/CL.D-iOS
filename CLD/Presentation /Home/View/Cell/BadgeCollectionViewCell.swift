//
//  BadgeCollectionViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

import RxSwift
import RxCocoa


protocol TapBadgeButtonDelegate: AnyObject {
    func badgeButtonTapped()
}

final class BadgeCollectionViewCell: UICollectionViewCell {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .CLDLightGray
        view.layer.cornerRadius = 10
        return view
    }()
    private let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "badge")
        return imageView
    }()
    private let badgeTitleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .boldSystemFont(ofSize: 16)
        UILabel.textColor = .CLDGold
        UILabel.text = "돌잡이들의 왕"
        return UILabel
    }()
    private let badgeSubLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 11)
        UILabel.textColor = .CLDDarkGray
        UILabel.text = "돌잡이들의 왕"
        return UILabel
    }()
    private let badgeRateLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 11)
        UILabel.textColor = .CLDDarkGray
        UILabel.text = "돌잡이 중 0% 획득"
        return UILabel
    }()
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        return stackView
    }()
    private let subTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 1
        return stackView
    }()
    private let allTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    private lazy var badgeInfoButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .mini
        configuration.title = "0"
        configuration.image = ImageLiteral.badgeInfoIcon.withRenderingMode(.alwaysTemplate)
        configuration.baseForegroundColor = .CLDGold
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        let button = UIButton()
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    private let videoSectionTitleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .boldSystemFont(ofSize: 16)
        UILabel.textColor = .black
        UILabel.text = "문제 풀이"
        return UILabel
    }()
    
    weak var delegate: TapBadgeButtonDelegate?
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setHierarchy()
        setConstraints()
        setViewProperty()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        badgeInfoButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.delegate?.badgeButtonTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func setHierarchy() {
        titleStackView.addArrangedSubview(badgeTitleLabel)
        subTitleStackView.addArrangedSubviews(badgeSubLabel, badgeRateLabel)
        allTitleStackView.addArrangedSubviews(titleStackView, subTitleStackView)
        
        addSubviews(backView, videoSectionTitleLabel)
        backView.addSubviews(badgeImageView, allTitleStackView, badgeInfoButton)
    }
    
    private func setConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.trailing.equalToSuperview().inset(23.5)
        }
        
        videoSectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(9)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
        
        badgeImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 102, height: 89))
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        allTitleStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(badgeImageView.snp.trailing).offset(30)
        }
                
        badgeInfoButton.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.top.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(18)
        }
    }
    
    private func setViewProperty() {
        self.backgroundColor = .white
    }
}
