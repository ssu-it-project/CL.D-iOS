//
//  SettingTableViewCell.swift
//  CLD
//
//  Created by 이조은 on 2023/09/14.
//

import UIKit

import SnapKit

class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
    private lazy var InfoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.numberOfLines = 1
        return label
    }()

    func setData(text: String) {
        self.InfoLabel.text = text
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none

        setViewHierarchy()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }

    private func setViewHierarchy() {
        self.addSubview(InfoLabel)
        // self.addSubview(nextBtn)
        // 기존 코드를 해석하면 cell에 photoView와 nextBtn이 올라가고 그 위에 contentView가 올라가기 때문에
        // self.contentView.addSubview(nextBtn)로 코드를 작성해 주어야지 contentView 위에 nextBtn이 올라간다.
    }

    private func setConstraints() {
        InfoLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(14)
        }
    }
}
