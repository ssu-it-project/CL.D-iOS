//
//  SelectListCell.swift
//  CLD
//
//  Created by 이조은 on 2023/07/30.
//

import UIKit

import SnapKit

final class SelectListCell: UICollectionViewCell {
    static let identifier = "SelectListCell"
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "cell"
        label.textColor = .CLDMediumGray
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        return label
    }()
    
    let dividerLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .CLDMediumGray
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cellLabel.textColor = .CLDGold
            } else {
                cellLabel.textColor = .CLDMediumGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellLabel)
        contentView.addSubview(dividerLabel)
        
        setUpLayouts()
    }
    func setUpLayouts() {
        cellLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5)
            $0.top.bottom.equalToSuperview()
        }
        dividerLabel.snp.makeConstraints {
            $0.leading.equalTo(cellLabel.snp.trailing).offset(5)
            $0.width.equalTo(2)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
