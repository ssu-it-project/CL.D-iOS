//
//  PhotoCollectionViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/08/14.
//

import UIKit

import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    let backgroundVideo: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 83, height: 81)
        imageView.image = ImageLiteral.videoThumbnail
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let labelBackground: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 19, height: 9)
        view.layer.backgroundColor = UIColor.CLDMediumGray.cgColor
        view.layer.opacity = 0.9
        view.layer.cornerRadius = 2
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:10"
        label.textColor = .white
        label.font = RobotoFont.Regular.of(size: 8)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundVideo.layer.borderColor = UIColor.CLDGold.cgColor
            } else {
                backgroundVideo.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundVideo)
        backgroundVideo.addSubview(labelBackground)
        labelBackground.addSubview(timeLabel)
        
        setUpLayouts()
    }
    func setUpLayouts() {
        backgroundVideo.snp.makeConstraints {
            $0.width.equalTo(83)
            $0.height.equalTo(81)
        }
        labelBackground.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(6)
            $0.width.equalTo(19)
            $0.height.equalTo(9)
        }
        timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

