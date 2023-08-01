//
//  BadgeCollectionViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/07/31.
//

import UIKit

import SnapKit

final class BadgeCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setHierarchy()
        setConstraints()
        setViewProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {}
    
    private func setConstraints() {}
    
    private func setViewProperty() {
        self.backgroundColor = .CLDOrange
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.green.cgColor
    }
}
