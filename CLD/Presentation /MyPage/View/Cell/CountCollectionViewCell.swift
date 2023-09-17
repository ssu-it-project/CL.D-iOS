//
//  CountCollectionViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/09/13.
//

import UIKit

import SnapKit

final class CountCollectionViewCell: UICollectionViewCell {
    static let identifier = "CountCollectionViewCell"

    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "372"
        label.textColor = .CLDBlack
        label.font = RobotoFont.Bold.of(size: 12)
        label.textAlignment = .center

        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "등반기록"
        label.textColor = .CLDBlack
        label.font = RobotoFont.Light.of(size: 10)
        label.textAlignment = .center

        return label
    }()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                countLabel.textColor = .CLDGold
                nameLabel.textColor = .CLDGold
            } else {
                countLabel.textColor = .CLDBlack
                nameLabel.textColor = .CLDBlack
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(countLabel)
        contentView.addSubview(nameLabel)

        setUpLayouts()
    }
    func setUpLayouts() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(72)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
