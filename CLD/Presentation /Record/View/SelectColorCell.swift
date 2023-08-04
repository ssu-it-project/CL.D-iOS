//
//  SelectColorCell.swift
//  CLD
//
//  Created by 이조은 on 2023/08/01.
//

import UIKit

import SnapKit

final class SelectColorCell: UICollectionViewCell {
    static let identifier = "SelectColorCell"
    
    private let backgroundRect: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 83, height: 81)
        view.layer.backgroundColor = UIColor.CLDLightGray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    var colorCircle: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 11
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 2
        return view
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "흰색"
        label.textColor = .CLDBlack
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundRect.layer.backgroundColor = UIColor.CLDLightGray.cgColor
            } else {
                backgroundRect.layer.backgroundColor = UIColor.CLDLightYellow.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backgroundRect)
        backgroundRect.addSubview(colorCircle)
        backgroundRect.addSubview(colorLabel)
        
        setUpLayouts()
    }
    func setUpLayouts() {
        backgroundRect.snp.makeConstraints {
            $0.width.equalTo(83)
            $0.height.equalTo(81)
        }
        colorCircle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.size.equalTo(22)
            $0.centerX.equalToSuperview()
        }
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(colorCircle.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(6)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

