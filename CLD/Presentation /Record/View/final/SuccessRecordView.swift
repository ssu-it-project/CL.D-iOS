//
//  SuccessRecordView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/13.
//

import UIKit

import SnapKit

final class SuccessRecordView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새 게시물"
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        return label
    }()
    private let thumbnailView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.thumbnailImage
        view.contentMode = .scaleAspectFill
        view.backgroundColor = nil
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let playIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "play.fill")
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.backgroundColor = nil
        return view
    }()
    private let labelBackground: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 27, height: 12)
        view.layer.backgroundColor = UIColor.CLDMediumGray.cgColor
        view.layer.opacity = 0.9
        view.layer.cornerRadius = 2
        return view
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:10"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        return label
    }()
    private let successLabel: UILabel = {
        let label = UILabel()
        label.text = "기록이 완료되었어요"
        label.textColor = .CLDBlack
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        return label
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유하기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        button.backgroundColor = .CLDLightGray
        button.setImage(ImageLiteral.instaLogo, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 6
        // button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    private let gotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("보러가기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .CLDLightGray
        button.layer.cornerRadius = 6
        // button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()

    func setSuccessRecord(_ thumbnailImage: UIImage) {
        thumbnailView.image = thumbnailImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setHierarchy() {
        addSubviews(titleLabel,thumbnailView,successLabel,shareButton,gotoButton)
        thumbnailView.addSubviews(playIcon,labelBackground)
        labelBackground.addSubview(timeLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.centerX.equalToSuperview()
        }
        thumbnailView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(217)
            $0.height.equalTo(212)
        }
        playIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(35)
            $0.height.equalTo(45)
        }
//        labelBackground.snp.makeConstraints {
//            $0.width.equalTo(27)
//            $0.height.equalTo(12)
//            $0.trailing.equalToSuperview().inset(12)
//            $0.bottom.equalToSuperview().inset(8)
//        }
//        timeLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
        successLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        shareButton.snp.makeConstraints {
            $0.top.equalTo(successLabel.snp.bottom).offset(132)
            $0.width.equalTo(340)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        gotoButton.snp.makeConstraints {
            $0.top.equalTo(shareButton.snp.bottom).offset(7)
            $0.width.equalTo(340)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
}
