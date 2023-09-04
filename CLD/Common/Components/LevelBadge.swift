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
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init()
        self.text = title
        self.backgroundColor = backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        layoutIfNeeded()
    }
    
    private func setUp() {
        heightAnchor.constraint(equalToConstant: 17).isActive = true
        widthAnchor.constraint(equalToConstant: 109).isActive = true
    }
    
    private func setLayout() {
        self.clipsToBounds = true
        self.font = UIFont(name: "Roboto-Black", size: 13)
        self.textColor = .white
        self.textAlignment = .center
    }
}
