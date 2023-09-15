//
//  LevelBadge.swift
//  CLD
//
//  Created by 김규철 on 2023/09/05.
//

import UIKit

final class LevelBadge: UILabel {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        layoutIfNeeded()
    }
    
    private func setUp() {
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    private func setLayout() {
        self.clipsToBounds = true
        self.font = UIFont(name: "Roboto-Black", size: 13)
        self.textColor = .white
        self.textAlignment = .center
    }
}

extension LevelBadge {
    func configurationLevelBadge(level: String, sector: String) {
        self.backgroundColor = level.getColorForLevel()
        self.text = "\(sector)|\(level)"
    }
}
