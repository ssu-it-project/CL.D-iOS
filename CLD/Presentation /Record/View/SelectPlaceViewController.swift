//
//  SelectPlaceViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/29.
//

import UIKit

import SnapKit

final class SelectPlaceViewController: BaseViewController {
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = .clear
        return view
    }()
    private let searchIconView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.searchIcon
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .CLDGray
        view.backgroundColor = nil
        return view
    }()
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소를 입력해주세요."
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray
        textField.borderStyle = .none
        return textField
    }()
    private let underLine: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 312, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.CLDBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        return button
    }()
    @objc private func nextView () {
        print("다음")
        // self.present(SelectSectorViewController(), animated: true)
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if self.view.frame.origin.y == 0 {
                // self.nextButton.frame.origin.y -= keyboardHeight
            }
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        // 키보드가 사라질 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            // self.nextButton.frame.origin.y += keyboardHeight
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        searchTextField.addLeftPadding()
        searchTextField.addLeftImageGray(image: ImageLiteral.searchIcon)
        
        searchTextField.layer.addSublayer((underLine))
        setHierarchy()
        setConstraints()
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setHierarchy() {
        self.view.addSubviews(searchTextField,dotDivider,nextButton)
    }
    
    override func setConstraints() {
        dotDivider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(88)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(312)
            $0.height.equalTo(31)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(101)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(28)
            $0.height.equalTo(18)
        }
    }
}
