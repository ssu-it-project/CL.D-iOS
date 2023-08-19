//
//  TermsTableViewCell.swift
//  CLD
//
//  Created by 김규철 on 2023/08/16.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class TermsTableViewCell: UITableViewCell {

    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.imageView?.tintColor = .CLDLightGray
        button.titleLabel?.textColor = .CLDLightGray
        return button
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor.CLDLightGray
        return button
    }()
    
    private let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSelected(selected)
    }
    
    func setLayout() {
        imageView?.image = UIImage(systemName: "checkmark")
        imageView?.tintColor = .CLDDarkGray
        textLabel?.textColor = .CLDDarkGray
        rightImageView.contentMode = .scaleAspectFill
        rightImageView.tintColor = .CLDDarkGray
        accessoryView = rightImageView
    }
    
    private func setHierarchy() {
        addSubview(termsButton)
    }
    
    private func setConstraints() {
        termsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setSelected(_ bool: Bool) {
        switch bool {
        case true:
            imageView?.tintColor = .CLDBlack
            textLabel?.textColor = .CLDBlack
            rightImageView.tintColor = .CLDBlack
        case false:
            imageView?.tintColor = .CLDDarkGray
            textLabel?.textColor = .CLDDarkGray
            rightImageView.tintColor = .CLDDarkGray
        }
    }
    
    
    func configCell(title: String) {
        textLabel?.text = title
    }
}
