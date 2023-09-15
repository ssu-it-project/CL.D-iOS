//
//  VideoCollectionViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

import SnapKit
import AVFoundation


final class VideoCollectionViewCell: UICollectionViewCell {
        
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.6
        imageView.layer.borderColor = UIColor.CLDBlack.cgColor
        return imageView
    }()
    private let titleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .systemFont(ofSize: 14)
        UILabel.textColor = .black
        return UILabel
    }()
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.videoCellMenuIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    var playerView = PlayerView()
    private let viedoTitleLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.sizeToFit()
        UILabel.font = .boldSystemFont(ofSize: 16)
        UILabel.textColor = .black
        return UILabel
    }()
    private let viedoDetailLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 14)
        UILabel.textColor = .CLDDarkGray
        return UILabel
    }()
    private let viedoDateLabel: UILabel = {
        let UILabel = UILabel()
        UILabel.font = .systemFont(ofSize: 14)
        UILabel.textColor = .CLDDarkGray
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.player = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(topLineView, profileImageView, titleLabel, menuButton, playerView, viedoTitleLabel, videoSubTitleStackView, buttonStackView)
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
        
        playerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.contentView.snp.height).multipliedBy(0.7)
        }
        
        viedoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(6)
        }
        
        videoSubTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(viedoTitleLabel.snp.bottom).offset(3)
            make.leading.equalTo(viedoTitleLabel.snp.leading)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(playerView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setViewProperty() {
        self.backgroundColor = .white
    }
}

extension VideoCollectionViewCell {
    func configureVideo(with videoURLString: String) {
        playerView.setupPlayerItem(with: videoURLString)
    }
}

extension VideoCollectionViewCell {
    func configureCell(row: RecordVO) {
        profileImageView.setImage(urlString: row.author.profileImage, defaultImage: ImageLiteral.myPageIcon)
        titleLabel.text = row.author.nickname
        viedoTitleLabel.text = row.content
        viedoDetailLabel.text = "\(row.climbingGymInfo.name) | \(row.sector) | \(row.level)"
        viedoDateLabel.text = row.date.created.convertToKoreanDateFormat()
    }
}
