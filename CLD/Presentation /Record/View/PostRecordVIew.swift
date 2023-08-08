//
//  PostRecordView.swift
//  CLD
//
//  Created by 이조은 on 2023/08/08.
//

import UIKit

import SnapKit

final class PostRecordView: UIView {
    private let thumbnailView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.thumbnailImage
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.backgroundColor = nil
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let playIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "play.fill")
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.backgroundColor = nil
        return view
    }()
    private let labelBackground: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 27, height: 12)
        view.layer.backgroundColor = UIColor.CLDMediumGray.cgColor
        view.layer.opacity = 0.9
        view.layer.cornerRadius = 2
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2:10"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "클라이밍을 기록해주세요."
        textView.font = UIFont(name: "Roboto-Light", size: 11)
        textView.textColor = .CLDDarkGray
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        textView.backgroundColor = .ChipWhite
        return textView
    }()
    private let underLine: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 71, width: 337, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    
    let placeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "클라이머스 김포공항"
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDDarkDarkGray
        textField.backgroundColor = .CLDLightGray
        textField.isUserInteractionEnabled = false
        return textField
    }()
    let sectorTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "7"
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray
        textField.isUserInteractionEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: "7", attributes: [NSAttributedString.Key.foregroundColor : UIColor.CLDDarkDarkGray])
        return textField
    }()
//    let colorTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "흰색"
//        textField.font = UIFont(name: "Roboto-Regular", size: 15)
//        textField.textColor = .CLDBlack
//        textField.backgroundColor = .CLDLightGray
//        textField.isUserInteractionEnabled = false
//        return textField
//    }()
    let colorTextView: UITextView = {
        let textView = UITextView()
        textView.text = "흰색"
        textView.font = UIFont(name: "Roboto-Regular", size: 15)
        textView.textColor = .CLDDarkDarkGray
        textView.textContainerInset = UIEdgeInsets(top: 7, left: 29, bottom: 7, right: 7);
        textView.backgroundColor = .CLDLightGray
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록하기", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        // button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        
        textView.layer.addSublayer((underLine))
        
        placeTextField.addLeftPadding()
        placeTextField.addLeftImageDarkGray(image: ImageLiteral.placeIcon)
        
        sectorTextField.addLeftPadding()
        sectorTextField.addLeftImageDarkGray(image: ImageLiteral.STIcon)
        
//        colorTextField.addLeftPadding()
//        colorTextField.addLeftImageDarkGray(image: ImageLiteral.VIcon)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        addSubviews(thumbnailView,textView,placeTextField,sectorTextField,colorTextView,recordButton)
        thumbnailView.addSubviews(playIcon,labelBackground)
        labelBackground.addSubview(timeLabel)
    }
    
    func setConstraints() {
        thumbnailView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(217)
            $0.height.equalTo(212)
        }
        playIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(35)
            $0.height.equalTo(45)
        }
        labelBackground.snp.makeConstraints {
            $0.width.equalTo(27)
            $0.height.equalTo(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(8)
        }
        timeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.bottom).offset(15)
            $0.width.equalTo(337)
            $0.height.equalTo(81)
            $0.centerX.equalToSuperview()
        }
        placeTextField.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(36)
            $0.width.equalTo(337)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        sectorTextField.snp.makeConstraints {
            $0.top.equalTo(placeTextField.snp.bottom).offset(5)
            $0.width.equalTo(337)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        colorTextView.snp.makeConstraints {
            $0.top.equalTo(sectorTextField.snp.bottom).offset(5)
            $0.width.equalTo(337)
            $0.height.equalTo(31)
            $0.centerX.equalToSuperview()
        }
        recordButton.snp.makeConstraints {
            $0.top.equalTo(colorTextView.snp.bottom).offset(44)
            $0.width.equalTo(55)
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
        }
    }
}
