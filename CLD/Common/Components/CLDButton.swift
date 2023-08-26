//
//  CLDButton.swift
//  CLD
//
//  Created by 김규철 on 2023/08/17.
//

import UIKit

final class CLDButton: UIButton {
        
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                self.backgroundColor = .CLDGold
            }
            else {
                self.backgroundColor = .CLDDarkGray
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, isEnabled: Bool) {
        self.init()
        setTitle(title, for: .normal)
        self.isEnabled = isEnabled
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
    }
    
    private func setUp() {
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    private func setLayout() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = .systemFont(ofSize: 16)
        
    }
}
