//
//  TermsCheckBox.swift
//  CLD
//
//  Created by 김규철 on 2023/08/17.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class TermsCheckBox: UIView {
        
    var isSelected = false {
        didSet {
            setDidTapUI()
        }
    }
    
    private var termsCheckBoxTapped = false
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.black
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.CLDBlack.cgColor
        button.layer.cornerRadius = 5
        button.isUserInteractionEnabled = false
        return button
    }()
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 동의하기"
        label.textColor = .CLDBlack
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    private var bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor.CLDDarkGray.cgColor
        self.backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
    }
    
    private func setHierarchy() {
        addSubviews(checkButton, checkLabel)
    }
    
    private func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        checkLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setDidTapUI() {
        if isSelected {
            layer.borderColor = UIColor.CLDBlack.cgColor
            checkButton.setImage(ImageLiteral.checkIcon, for: .normal)
        } else {
            layer.borderColor = UIColor.CLDDarkGray.cgColor
            checkButton.setImage(nil, for: .normal)
        }
    }
}


extension TermsCheckBox {
    func termsCheckBoxToggleisSeleted() -> Signal<Bool> {
        return self.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .map {  onwer, _ in
                onwer.isSelected.toggle()
                return onwer.isSelected
            }
            .asSignal(onErrorSignalWith: Signal.empty())
    }
    
    func termsCheckBoxDidTapGesture() -> Signal<Bool> {
        return self.rx.tapGesture().when(.recognized)
            .withUnretained(self)
            .map {  onwer, _ in
                onwer.termsCheckBoxTapped.toggle()
                return onwer.termsCheckBoxTapped
            }
            .asSignal(onErrorSignalWith: Signal.empty())
    }
}

