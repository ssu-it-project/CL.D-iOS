//
//  BadgeCollectionViewCell.swift.swift
//  CLD
//
//  Created by 이조은 on 2023/09/13.
//

import UIKit

import SnapKit
import RxSwift
import RxGesture
import RxCocoa

protocol PushVideoDelegate: AnyObject {
    func videoButtonTapped()
}

final class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "HistoryCollectionViewCell"

    let cellBackgroundView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .CLDLightGray
        uiView.layer.cornerRadius = 10

        return uiView
    }()
    let badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.testBadgeImage
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "돌잡이들의 왕"
        label.textColor = .CLDBlack
        label.font = RobotoFont.Bold.of(size: 11)
        label.textAlignment = .center

        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.6.05 | A섹터 | 보라색"
        label.textColor = .CLDMediumGray
        label.font = RobotoFont.Light.of(size: 10)
        label.textAlignment = .center

        return label
    }()
    let videoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(ImageLiteral.videoIcon, for: .normal)

        return button
    }()

    weak var delegatePushVideo: PushVideoDelegate?
    private var bag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubviews(badgeImageView, titleLabel, dateLabel, videoButton)

        setUpLayouts()
        bind()
    }
    func setUpLayouts() {
        cellBackgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(352)
            $0.height.equalTo(76)
        }
        badgeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(74)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(74)
        }
        videoButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(12)
        }
    }

    private func bind() {
        videoButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { owner, event in
                owner.delegatePushVideo?.videoButtonTapped()
            })
            .disposed(by: bag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
