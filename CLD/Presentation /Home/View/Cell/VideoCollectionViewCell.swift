//
//  VideoCollectionViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

import SnapKit

final class VideoCollectionViewCell: UICollectionViewCell {
    
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "videoCellProfleImage")
        return imageView
    }()
    private let titleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .systemFont(ofSize: 12)
        UILabel.textColor = .black
        UILabel.text = "김성진죽지마화이팅"
        return UILabel
    }()
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.videoCellMenuIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    private let videoView = UIView()
    private let viedoTitleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .boldSystemFont(ofSize: 15)
        UILabel.textColor = .black
        UILabel.text = "이게 진짜 가능하다가??"
        return UILabel
    }()
    private let viedoDetailLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 11)
        UILabel.textColor = .CLDDarkGray
        UILabel.text = "클라이밍장 정보 | A | 빨강 "
        return UILabel
    }()
    private let viedoDateLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 11)
        UILabel.textColor = .CLDDarkGray
        UILabel.text = "2023.05.21"
        return UILabel
    }()
    private lazy var videoSubTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 1
        stackView.addArrangedSubviews(viedoDetailLabel, viedoDateLabel)
        return stackView
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.likeIcon, for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.commentIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.shareIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.addArrangedSubviews(likeButton, commentButton, shareButton)
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setHierarchy()
        setConstraints()
        setViewProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(topLineView, profileImageView, titleLabel, menuButton, videoView, viedoTitleLabel, videoSubTitleStackView, buttonStackView)
    }
    
    private func setConstraints() {
        topLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 36))
            make.top.equalTo(topLineView.snp.bottom).offset(6.5)
            make.leading.equalToSuperview().inset(6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
        
        videoView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.contentView.snp.height).multipliedBy(0.7)
        }
        
        viedoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(videoView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(6)
        }
        
        videoSubTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(viedoTitleLabel.snp.bottom).offset(3)
            make.leading.equalTo(viedoTitleLabel.snp.leading)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(videoView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setViewProperty() {
        self.backgroundColor = .white
        videoView.backgroundColor = .CLDOrange
    }
    
    
}
