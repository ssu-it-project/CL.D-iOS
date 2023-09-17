//
//  seeMoreVideosView.swift
//  CLD
//
//  Created by 김규철 on 2023/09/05.
//

import UIKit

final class MoreVideosView: UIView {
    
    let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("영상 더보기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = RobotoFont.Regular.of(size: 13)
        button.backgroundColor = .white
        button.clipsToBounds = true
        return button
    }()
    private let levelLabel = LevelBadge()
    private let videoBackView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    private var videoView = PlayerView()
    private let videoSampleImageView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.DefaultDetailGymVideoImage
        view.isHidden = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .CLDGray
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoButton.layer.cornerRadius = 11
        self.layer.cornerRadius = 11
        videoBackView.layer.cornerRadius = 11
    }
    
    private func setHierarchy() {
        videoBackView.addSubviews(levelLabel, videoSampleImageView, videoView)
        videoBackView.bringSubviewToFront(levelLabel)
        addSubviews(videoButton, videoBackView)
        videoView.addSubview(levelLabel)
    }
    
    private func setConstraints() {
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        videoSampleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
        }
        
        videoBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(27)
        }
        
        videoButton.snp.makeConstraints { make in
            make.top.equalTo(videoBackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(27)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension MoreVideosView {
    func configureVideoURL(videoURL: String) {
        videoView.setupPlayerItem(with: videoURL)
    }
    
    func handleHiddenVideoSampleImageView(_ isHidden: Bool) {
        videoSampleImageView.isHidden = isHidden
    }
    
    func setLevelLabel(level: String, section: String) {
        levelLabel.configurationLevelBadge(level: level, sector: section)
    }
}
