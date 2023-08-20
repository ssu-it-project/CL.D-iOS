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
import RxGesture

protocol PushTermsViewDelegate: AnyObject {
    func cellButtonTapped(index: Int)
}

final class TermsTableViewCell: UITableViewCell {
    
    private var bag = DisposeBag()
    weak var delegate: PushTermsViewDelegate?

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
    let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setConstraints()
        setLayout()
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSelectedCell(selected)
    }
    
    private func setGesture() {
        rightImageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.delegate?.cellButtonTapped(index: self?.rightImageView.tag ?? 0)
            })
            .disposed(by: bag)
    }
    
    private func setSelectedCell(_ bool: Bool) {
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
    
    func setLayout() {
        self.selectionStyle = .none
        
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

    func configCell(title: String) {
        textLabel?.text = title
    }
}
