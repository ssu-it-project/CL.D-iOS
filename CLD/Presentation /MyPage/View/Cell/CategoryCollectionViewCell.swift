//
//  CategoryCollectionViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/09/15.
//

import UIKit

import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.textColor = .CLDBlack
        label.font = RobotoFont.Bold.of(size: 14)
        label.textAlignment = .center

        return label
    }()

    func setCategory(text: String) {
        self.categoryLabel.text = text
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryLabel.textColor = .CLDGold
            } else {
                categoryLabel.textColor = .CLDBlack
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViewHierarchy()
        setConstraints()
    }

    private func setViewHierarchy() {
        self.addSubview(categoryLabel)
    }

    private func setConstraints() {
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(2)
            $0.height.equalTo(20)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
