//
//  ClimbingGymVideoCollectionViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/09/16.
//

import UIKit

final class ClimbingGymVideoCollectionViewCell: UICollectionViewCell {
    
    private let levelLabel = LevelBadge()
    private let videoBackView = UIView()
    private var videoView = PlayerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoView.player = nil
    }
    
    private func setHierarchy() {
        videoBackView.addSubviews(levelLabel, videoView)
        videoBackView.bringSubviewToFront(levelLabel)
        self.addSubview(videoBackView)
    }
    
    private func setConstraints() {
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.centerX.equalToSuperview()
        }
        
        videoBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ClimbingGymVideoCollectionViewCell {
    func configureCell(row: RecordVO) {
        videoView.setupPlayerItem(with: row.video.original)
        levelLabel.configurationLevelBadge(level: row.level, sector: row.sector)
    }
}

